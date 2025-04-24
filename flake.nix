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


    langs = [ "en" "en-te" "sv" "sv-te" "tp" "tp-te" "tp-sp" "tp-jp" ];

    getDirName = n: builtins.concatStringsSep "/" (lib.dropEnd 1 (lib.flatten (builtins.split "/" (builtins.toString n))));
    getPathConverted = n: (builtins.replaceStrings
      [ ".css.nix" ".nix"  ]
      [ ".css"     ".html" ]
      n
    );
    getFileNameConverted = n: (getPathConverted
      (lib.last (builtins.split "/" (builtins.toString n)))
    );




    getInputPath = { path, lang ? "en", tendrilis ? false, langURL ? lang }@fileData:
      if lib.hasSuffix ".nix" (builtins.toString path)
      then loadNixFile fileData
      else path; # return path to file in nix store
    

    loadNixFile = { path, lang ? "en", tendrilis ? false }: let
      pageData = import path { inherit templates; };
      templateFunc = import pageData.template;
      pageDataLangd = langConvert.${lang} (pageData // {inherit path getFileNameConverted markdownConvert sitelen-pona-UCSUR tendrilis;});
    in
      (builtins.toFile (getFileNameConverted path)
        (pageData.content or (templateFunc pageDataLangd)));





    langConvert = {
      en = f: f // {
        content = markdownConvert { content = f.en; };
      };
      en-te = f: f // {
        content = markdownConvert { content = f.en; tendrilis = true; };
      };

      sv = f: f // {
        content = markdownConvert { content = f.sv; };
      };
      sv-te = f: f // {
        content = markdownConvert { content = f.sv; tendrilis = true; };
      };

      tp = f: f // {
        content = markdownConvert { content = (sitelen-pona-UCSUR.ucsur2lasina f.tp); };
      };
      tp-te = f: f // {
        content = markdownConvert { content = (sitelen-pona-UCSUR.ucsur2lasina f.tp); tendrilis = true; };
      };
      tp-sp = f: f // {
        content = builtins.replaceStrings
          [ "󱦜\n"    "󱤔"  ]
          [ "</br>" "<span class=\"asuki\">kala2</span>" ]
          (markdownConvert { content = f.tp; });
      };
      tp-jp = f: f // {
        content = builtins.replaceStrings
          [ "󱦜\n"    ]
          [ "</br>" ]
          (markdownConvert { content = (sitelen-pona-UCSUR.ucsur2hiragana f.tp); });
      };

      content = f: f // {
        content = f.content or "";
      };
    };


    markdownConvert = { content, tendrilis ? false }: builtins.replaceStrings
      [ "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" "'"     "\n\n"        "\n    \n"    ]
      [ "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" "&#39;" "\n</p><p>\n" "\n</p><p>\n" ]
      (if tendrilis then tendrilisConvert content else content);

    tendrilisConvert = content: builtins.replaceStrings
      [ "    " "  " " [" "] " "[" "]" ", " ". "    " " ]
      [ ""     ""   "("  ")"  "(" ")" "," ".</br>" "/" ]
      content;



  in rec {


    # attrset, each value is string of output path
    site = builtins.listToAttrs siteList;

    # has a bazillion duplicates of all binary files
    siteList = lib.flatten (lib.forEach filesList (f: 
      lib.forEach langs (lang:
        if lib.hasSuffix ".nix" f then
          if builtins.hasAttr lang (import f { inherit templates; })
          then {
            name = builtins.substring 55 999 ((getDirName f) + "/" + lang + "/" + (getFileNameConverted f));
            value = getInputPath { path = f; inherit lang; };
          }
          else if builtins.hasAttr "content" (import f { inherit templates; })
            then {
              name = builtins.substring 54 999 ((getDirName f) + "/" +  (getFileNameConverted f));
              value = getInputPath { path = f; lang = "content"; };
            }
            else []
        else {
          name = getPathConverted (builtins.substring 55 999 (builtins.toString f));
          value = getInputPath { path = f; lang = "content"; }; }
      )));

    # list of input files
    filesList = lib.filesystem.listFilesRecursive ./src;


    # build an attrset from siteList to easily check if a page exists

    # linkTo = { path, lang, writ, ... }: let
    #   link = if lib.hasAttr path siteList then (lib.concatStrings path + "")
    #     else (linkTo { inherit path; lang = "en"; writ = ""; });
    #   linkFinal = builtins.replaceStrings ["."] ["/"] link;
    # in ''<a href=${linkFinal}>text</a>'';


    linkCommands = (lib.mapAttrsToList (name: value:
      ''mkdir -p $out/${getDirName name} && ln -s ${value} $out/${name}'')
    ) site;


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