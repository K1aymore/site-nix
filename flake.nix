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



    getInputPath = dir: path: lang:
      if lib.hasSuffix ".nix" (lib.last path)
      then loadNixFile dir path lang
      else dir + ("/" + getPath path);
    

    loadNixFile = dir: path: lang: let
      imported = import (dir + ("/" + getPath path)) { inherit templates; };
    in
      builtins.toFile (getFileNameConverted (lib.last path))
        (imported.content or (
          (import imported.template) ((langConvert.${lang} imported) // {inherit sitelen-pona-UCSUR; path = getPathConverted path;})
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

      tp = f: f // {
          lang = "tp";
          content = markdownConvert (sitelen-pona-UCSUR.ucsur2lasina f.tp);
        };

      tp-sp = f: f // {
        lang = "tp-sp";
        content = builtins.replaceStrings
          [ "\n"    "󱤔"  ]
          [ "</br>" "<span class=\"asuki\">kala2</span>" ]
          (markdownConvert f.tp);
      };
    };

    markdownConvert = s: builtins.replaceStrings
      [ "'" "\n\n" "\n\t\t\n" "↗️" "↘️" "⬆️" "⬇️" "▶️" "◀️" ]
      [ "’" "</p><p>" "</p><p>" "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" ]
      s;


  in rec {

    # value of attrs is path to file in store
    site = {
      parts = loadDir ./templates/globals "en";
      en = loadDir ./src "en";
      sv = loadDir ./src "sv";
      tp = loadDir ./src "tp";
      tp-sp = loadDir ./src "tp-sp";
    };


    loadDir = dir: lang: lib.mapAttrsRecursive (path: val: getInputPath dir path lang) (getDir dir);


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