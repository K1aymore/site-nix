{

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = { nixpkgs, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    lib = nixpkgs.lib;

    templates = {
      page = ./templates/page.nix;
      blog = ./templates/page.nix;
      comic = ./templates/comic.nix;
    };

    nixFiles = [
      ./site/index.nix
      ./site/comics/index.nix
    ];

    otherFiles = [
      ./site/parts/style.css.nix
    ];

    binaries = [
      ./site/parts/sitelen-seli-kiwen-asuki.ttf
      ./site/parts/sitelen-seli-kiwen-juniko.ttf
      ./site/parts/nasin-nanpa-4.0.2.otf
      ./site/parts/nasin-nanpa-4.0.2-UCSUR.otf
    ];


    getFileName = f: builtins.substring 56 999 (toString f);


    langs = [ "en" "sv" "tp" "tp-sp" ];

    languageConversions = {
      en = f: f // {
        lang = "en";
        prehtml = f.en;
      };

      sv = f: f // {
        lang = "sv";
        prehtml = f.sv;
      };

      tp = f: [
        # latin toki pona
        ( f // {
          lang = "tp";
          prehtml = builtins.replaceStrings
            [ "&" ]
            [ " " ]
            f.tp;
        })
        # sitelen pona
        ( f // {
          lang = "tp-sp";
          prehtml = builtins.replaceStrings
            [ ".." ". " "." ","  "\nkala" " kala"  "\nakesi" " akesi" "soko"  ]
            [ ".." "</br>" "" "" "\nkala2" " kala2" "\nakesi2" " akesi2" "soko" ]
            f.tp;
        })
      ];
    };

    langify = f: lang:
      if builtins.hasAttr lang f
        then (builtins.getAttr lang languageConversions f)
        else [];

  in rec {

    # Imports files and splits them into different languages
    langSplit =
      (map (f: removeAttrs f langs)

      # separate languages
      # the flattening is so the empty lists go away
      (builtins.concatLists
      (map (f: if builtins.hasAttr "content" f then [f] else lib.flatten [ (map (langify f) langs) ])

      # import data
      (map (f: import f templates // { path = builtins.replaceStrings [ ".nix" ] [ ".html" ] (getFileName f); })
      nixFiles))));
    

    # converts my silly markup lang into html
    markdownConverted =
      map (f: f // { content = builtins.replaceStrings
          [ "\n\n" "\n\t\t\n" "↗️" "↘️" "⬆️" "⬇️" "▶️" "◀️" ]
          [ "</p><p>" "</p><p>" "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" ]
          f.prehtml; })
      langSplit;
    
    # puts content into templates
    pages =
      map (f: (f // { content = import f.template f; }))
      markdownConverted;


    other = (map (f: import f // { path = builtins.replaceStrings [".css.nix" ] [ ".css" ] (getFileName f); })
      otherFiles);


    binaryResults = {};


    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "klaymore.me";

      system = builtins.currentSystem;

      src = ./.;  # Include source files in the derivation

      buildPhase = ''
        echo "building files..."
        ${builtins.concatStringsSep "\n" (map (f: "mkdir -p $out/${f.lang}/$(dirname ${f.path}) && echo '${f.content}' > $out/${f.lang}/${f.path}") pages)}

        ${builtins.concatStringsSep "\n" (map (f: "mkdir -p $out/$(dirname ${f.path}) && echo '${f.content}' > $out/${f.path}") other)}

        ${builtins.concatStringsSep "\n" (map (f: "mkdir -p $out/$(dirname ${f}) && cp '${f}' $out/${getFileName f}") binaries)}
      '';

      installPhase = ''
        echo "Conversion completed. HTML files are in $out"
      '';
    };

  };

}