{

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = { nixpkgs, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    templates = {
      page = ./templates/page.nix;
      blog = ./templates/page.nix;
      comic = ./templates/comic.nix;
    };

    files = [
      ./site/index.nix
      ./site/comics/index.nix
    ];


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
      (map (f: if builtins.hasAttr "content" f then f else nixpkgs.lib.flatten [ (map (langify f) langs) ])

      # import data
      (map (f: import f templates // { path = builtins.replaceStrings [".nix"] [".html"] (builtins.substring 56 999 (toString f)); })
      files))));
    

    markdownConverted =
      map (f: f // { content = builtins.replaceStrings
        [ "↗️" "↘️" "⬆️" "⬇️" "▶️" "◀️" ]
        [ "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" ]
        f.content; } )
      langSplit;
    

    result =
      map (f: { path = f.path;
                html = import f.template f; })
      markdownConverted;


    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "klaymore.me";

      system = builtins.currentSystem;

      src = ./.;  # Include source files in the derivation

      buildPhase = ''
        mkdir -p $out/comics
        mkdir -p $out/sv/comics
        echo "building files..."
        ${builtins.concatStringsSep "\n" (map (f: "echo '${f.html}' > $out/${f.path}") result)}
      '';

      installPhase = ''
        echo "Conversion completed. HTML files are in $out"
      '';
    };

  };

}