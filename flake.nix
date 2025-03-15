{

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sitelen-pona-UCSUR = {
      url = "github:K1aymore/nix-utils?dir=sitelen-pona-UCSUR";
    };
  };

  outputs = { nixpkgs, sitelen-pona-UCSUR, ... }: let
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


    langs = [ "en" "sv" "tp" "tp-sp" ];



    loadFile = path: lang:
      if lib.hasSuffix ".nix" (lib.last path)
      then loadNixFile path lang
      else ./site + ("/" + getPath path);
    

    loadNixFile = path: lang: let
      imported = import (./site + ("/" + getPath path)) { inherit templates; };
    in
      builtins.toFile (getFileNameConverted (lib.last path))
        (imported.content or (
          (import imported.template) ((langConvert.${lang} imported) // {inherit sitelen-pona-UCSUR; path = getPath path;})
        ));




    langConvert = {
      en = f: f // {
        lang = "en";
        content = markdownConvert f.en;
      };

      sv = f: f // {
        lang = "sv";
        content = markdownConvert f.sv;
      };

      tp = f: [
        # latin toki pona
        ( f // {
          lang = "tp";
          content = markdownConvert (sitelen-pona-UCSUR.ucsur2lasina f.tp);
        })
        # sitelen pona
        ( f // {
          lang = "tp-sp";
          content = builtins.replaceStrings
            [ "\n"    "󱤔"  ]
            [ "</br>" "<span class=\"asuki\">kala2</span>" ]
            (markdownConvert f.tp);
        })
      ];
    };

    markdownConvert = s: builtins.replaceStrings
      [ "'" "\n\n" "\n\t\t\n" "↗️" "↘️" "⬆️" "⬇️" "▶️" "◀️" ]
      [ "’" "</p><p>" "</p><p>" "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" ]
      s;


  in rec {


    filesList = lib.collect (v: builtins.isPath v) site;


    # value of attrs is path to file in store
    site = {
      en = getLang "en";
      sv = getLang "sv";
    };


    getLang = lang: lib.mapAttrsRecursive (path: val: loadFile path lang) src;


    src = getDir ./site;


    # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
    getDir = dir: lib.mapAttrs
      (file: type:
        if type == "directory" then getDir "${dir}/${file}" else type
      )
      (builtins.readDir dir);



    linkCommands = lib.collect lib.isString
      (lib.mapAttrsRecursive (path: value:
        ''mkdir -p $out/${getDirPath path} && ln -s ${value} $out/${getPathConverted path}'')
        site);


    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "klaymore.me";
      system = builtins.currentSystem;
      src = ./site;

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