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
      ./site/parts/style.css.nix
    ];

    binaries = [
      ./site/parts/linja-pona-4.1.woff
    ];


    getFileName = f: builtins.substring 56 999 (toString f);


    langs = [ "en" "sv" "tp" "sp" ];

    languageConversions = {
      en = f: f // {
        lang = "en";
        content = f.en;
      };

      sv = f: f // {
        lang = "sv";
        content = f.sv;
        path = "sv/${f.path}";
      };

      tp = f: [
        # latin toki pona
        ( f // {
          lang = "tp";
          content = builtins.replaceStrings
            [ " - " " -- " "_" "-" "--" "---" ]
            [ " - " " -- " " " " " " "  " " ]
            f.tp;
          path = "tp/${f.path}";
        })
        # sitelen pona
        ( f // {
          lang = "sp";
          content = f.tp;
          path = "sp/${f.path}";
        })
      ];
    };

    langify = f: lang: (if builtins.hasAttr lang f then (builtins.getAttr lang languageConversions f) else []);

  in rec {

    langSplit =
      (map (f: removeAttrs f langs)

      # separate languages
      # the flattening is so the empty lists go away
      (builtins.concatLists
      (map (f: if builtins.hasAttr "content" f then [f] else lib.flatten [ (map (langify f) langs) ])

      # import data
      (map (f: import f templates // { path = builtins.replaceStrings [".css.nix" ".nix"] [".css" ".html"] (getFileName f); })
      nixFiles))));
    

    markdownConverted =
      map (f: f // { content = builtins.replaceStrings
        [ "↗️" "↘️" "⬆️" "⬇️" "▶️" "◀️" ]
        [ "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" ]
        f.content; } )
      langSplit;
    

    result =
      map (f: if builtins.hasAttr "template" f
        then { path = f.path;
               content = import f.template f; }
        else f)
      markdownConverted;

    binaryResults = {};

    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "klaymore.me";

      system = builtins.currentSystem;

      src = ./.;  # Include source files in the derivation

      buildPhase = ''
        mkdir -p $out/comics
        mkdir -p $out/sv/comics
        mkdir -p $out/tp/comics
        mkdir -p $out/sp/comics
        mkdir -p $out/parts
        echo "building files..."
        ${builtins.concatStringsSep "\n" (map (f: "echo '${f.content}' > $out/${f.path}") result)}

        ${builtins.concatStringsSep "\n" (map (f: "cp '${f}' $out/${getFileName f}") binaries)}
      '';

      installPhase = ''
        echo "Conversion completed. HTML files are in $out"
      '';
    };

  };

}