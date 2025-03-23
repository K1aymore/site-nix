{

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sitelen-pona-UCSUR = {
      url = "github:K1aymore/nix-utils?dir=sitelen-pona-UCSUR";
    };
  };

  outputs = { nixpkgs, sitelen-pona-UCSUR, ... }@inputs: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    lib = nixpkgs.lib;

    templates = {
      page = ./templates/page.nix;
      blog = ./templates/page.nix;
      comic = ./templates/comic.nix;
    };



    getFileNameConverted = n: builtins.replaceStrings
      [ ".css.nix" ".nix"  ]
      [ ".css"     ".html" ]
      n;
    getPath = path: builtins.concatStringsSep "/" path;
    getPathConverted = path: getFileNameConverted (getPath path);
    getDirPath = path: getPath (lib.dropEnd 1 path);


    langs = [ "en" "sv" "tp" "tp-sp" "tp-jp" ];
    tendrilisLangs = [ "en" "sv" "tp" ];



    # dir is starting path to load from, path is output path
    getInputPath = { dir, path, lang ? "", tendrilis ? false, langURL ? lang }@fileData:
      if lib.hasSuffix ".nix" (lib.last path)
      then loadNixFile fileData
      else dir + ("/" + getPath path); # return path to file in nix store
    

    loadNixFile = { dir, path, lang, langURL, tendrilis }: let
      pageData = import (dir + ("/" + getPath path)) { inherit templates; };
      templateFunc = import pageData.template;
      pageDataLangd = langConvert.${lang} (pageData // {inherit lang path langURL getPathConverted markdownConvert sitelen-pona-UCSUR tendrilis;});
    in
      (builtins.toFile (getFileNameConverted (lib.last path))
        (pageData.content or (templateFunc pageDataLangd)));


    langConvert = {
      en = f: f // {
        content = (markdownConvert { tendrilis = f.tendrilis; content = f.en;});
      };

      sv = f: f // {
        content = (markdownConvert { tendrilis = f.tendrilis; content = f.sv;});
      };

      tp = f: f // {
        content = (markdownConvert { tendrilis = f.tendrilis; content = (sitelen-pona-UCSUR.ucsur2lasina f.tp);});
      };

      tp-sp = f: f // {
        content = builtins.replaceStrings
          [ "\n"    "󱤔"  ]
          [ "</br>" "<span class=\"asuki\">kala2</span>" ]
          (markdownConvert {tendrilis = f.tendrilis; content = f.tp;});
      };
      
      tp-jp = f: f // {
        content = builtins.replaceStrings
          [ "\n"    ]
          [ "</br>" ]
          (markdownConvert {tendrilis = f.tendrilis; content = (sitelen-pona-UCSUR.ucsur2hiragana f.tp);});
      };

      # tp-hg = f: f // {
      #   lang = "tp-hg";
      #   content = markdownConvert (sitelen-pona-UCSUR.ucsur2hangeul f.tp-hg or f.en);
      # };
    };


    markdownConvert = { content, tendrilis ? false }: builtins.replaceStrings
      [ "'"     "\n\n" "\n    \n" "↗️" "↘️" "⬆️" "⬇️" "▶️" "◀️" ]
      [ "&#39;" "\n</p><p>\n" "\n</p><p>\n" "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" ]
      (if tendrilis then tendrilisConvert content else content);

    tendrilisConvert = content: builtins.replaceStrings
      [ "    " "  " " [" "] " "[" "]" ", " ". "    " " ]
      [ ""     ""   "("  ")"  "(" ")" "," ".</br>" "/" ]
      content;



  in rec {

    # value of attrs is path to file in store
    site = {
      parts = loadDir { dir = ./globals; };

      en = loadDir { lang = "en"; };
      sv = loadDir { lang = "sv"; };
      tp = loadDir { lang = "tp"; };
      tp-sp = loadDir { lang = "tp-sp"; };
      tp-jp = loadDir { lang = "tp-jp"; };

      te.en = loadDir { lang = "en"; tendrilis = true; };
      te.sv = loadDir { lang = "sv"; tendrilis = true; };
      te.tp = loadDir { lang = "tp"; tendrilis = true; };
      te.tp-sp = loadDir { lang = "tp"; tendrilis = true; langURL = "tp-sp"; };
      te.tp-jp = loadDir { lang = "tp"; tendrilis = true; langURL = "tp-jp"; };

      "favicon.ico" = getInputPath { dir = ./globals; path = [ "favicon.ico" ]; };
    };

    # path is list of folders ending with file name
    loadDir = { dir ? ./src, lang ? "", tendrilis ? false, langURL ? lang }: lib.mapAttrsRecursive (path: val: getInputPath {inherit dir path lang langURL tendrilis;}) (getDir dir);

    # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
    getDir = dir: lib.mapAttrs
      (file: type: if type == "directory" then getDir "${dir}/${file}" else type)
      (builtins.readDir dir);




    linkCommands = lib.collect lib.isString
      (lib.mapAttrsRecursive (path: value:
        ''mkdir -p $out/${getDirPath path} && ln -s ${value} $out/${getPathConverted path}'')
        site);


    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "klaymore.me";
      system = builtins.currentSystem;
      src = ./src;

      buildInputs = [ pkgs.brotli ];

      buildPhase = ''
        echo "building files..."

        ${builtins.concatStringsSep "\n" linkCommands}
      '';

      installPhase = ''
        echo "Conversion completed. HTML files are in $out"
      '';
    };

  };

}