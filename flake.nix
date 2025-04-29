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
      page = import ./templates/page.nix;
      blog = import ./templates/page.nix;
      comic = import ./templates/comic.nix;
    };


    langs = [ "en" "sv" "tp" ];
    writs = [ "" "-te" "-sp" "-jp" ];

    getDirName = n:  let
      path = builtins.concatStringsSep "/" (lib.dropEnd 1 (lib.flatten (builtins.split "/" (getPathConverted n))));
    in 
      if path == ""
      then ""
      else "/" + path;
    
    getDirNoLangs = n: let
      dir = getDirName n;
      dirs = lib.flatten (lib.forEach langs (lang: lib.forEach writs (writ:
        if lib.hasSuffix ("/" + lang + writ) dir
        then lib.removeSuffix (lang + writ) dir
        else []
      )));
    in 
      if dirs == []
      then dir
      else builtins.head dirs;
    
    getPathConverted = n: let
      path = if lib.hasPrefix "/nix/store/" (builtins.toString n)
        then builtins.substring 55 999 (builtins.toString n)
        else builtins.toString n;
    in
      (builtins.replaceStrings
      [ ".nix"  ]
      [ ".html" ]
      path
    );

    getFileNameConverted = n: builtins.baseNameOf (getPathConverted n);


    loadLang = { f, lang ? "", writ ? "" }: if (builtins.hasAttr (lang+writ) langConvert)
      then {
        name = builtins.replaceStrings ["//" "/en/"] ["/" "/"]
          ((getDirName f) + "/" + lang + writ + "/" + (getFileNameConverted f));
        value = loadNixFile { path = f; inherit lang writ; };
      }
      else [];
    

    loadNixFile = { path, lang ? "en", writ ? "" }: let
      pageData = import path { };
      pageDataLangd = langConvert.${lang + writ} (pageData // {inherit path getDirName getDirNoLangs getFileNameConverted langConvert urlTo markdownConvert sitelen-pona-UCSUR lang writ;});
    in
      (builtins.toFile (getFileNameConverted path)
        (pageData.content or (templates.${pageData.template or "page"} pageDataLangd)));





    langConvert = {
      en = f: f // {
        content = markdownConvert { content = f.en; };
      };
      en-te = f: f // {
        content = markdownConvert { content = f.en; writ = f.writ; };
      };

      sv = f: f // {
        content = markdownConvert { content = f.sv; };
      };
      sv-te = f: f // {
        content = markdownConvert { content = f.sv; writ = f.writ; };
      };

      tp = f: f // {
        content = markdownConvert { content = (sitelen-pona-UCSUR.ucsur2lasina f.tp); };
      };
      tp-te = f: f // {
        content = markdownConvert { content = (sitelen-pona-UCSUR.ucsur2lasina f.tp); writ = f.writ; };
      };
      tp-sp = f: f // {
        content = builtins.replaceStrings
          [ "󱦜\n"    "󱤔"  ]
          [ "</br>" "<span class=\"asuki\">kala2</span>" ]
          (markdownConvert { content = f.tp; writ = f.writ; });
      };
      tp-jp = f: f // {
        content = builtins.replaceStrings
          [ ".\n"   ]
          [ "</br>" ]
          (markdownConvert { content = (sitelen-pona-UCSUR.ucsur2hiragana f.tp); writ = f.writ; });
      };
    };


    urlTo = { url, lang ? "en", writ ? "", from ? "/" }: let
      mainPart = (if (lib.hasPrefix "/" url) then url else url);
      langPart = (if lang == "en" && writ == "" then "" else lang + writ);
    in
      lib.strings.normalizePath (mainPart + "/" + langPart);

    markdownConvert = { content, writ ? "" }: builtins.replaceStrings
      [ "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" "'"   "\\ " "\n\n"        "\n    \n" ]
      [ "<em>" "</em>" "<strong>" "</strong>" "<li>" "</li>" "&#39;" " " "\n</p><p>\n" "\n</p><p>\n" ]
      (if writ == "-te" then tendrilisConvert content else content);

    tendrilisConvert = content: builtins.replaceStrings
      [ "    "  "   "  "  "   " [" "] " "[" "]" ", " ". "    "\\ " " \n"  " " ]
      [ ""      ""     ""     "("  ")"  "(" ")" ","  ".</br>"  " "  "\n"  "/" ]
      content;



  in rec {

    # attrset, each name is string of output path, value of path in store
    site = builtins.listToAttrs siteList;


    siteList = lib.flatten (lib.forEach filesList (f: 
      if lib.hasSuffix ".nix" f
      then if builtins.hasAttr "content" (import f { inherit templates; })
        then loadLang { inherit f; }
        else lib.forEach langs (lang: lib.forEach writs (writ: loadLang { inherit f lang writ; }))
      else {
        name = getPathConverted f;
        value = f;
      }
      ));


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

        ${lib.concatLines linkCommands}
      '';

      installPhase = ''
        echo "Conversion completed. HTML files are in $out"
      '';
    };

  };

}