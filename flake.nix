{

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = { self, nixpkgs, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    templates = {
      page = ./templates/page.nix;
    };

    files = [
      ./site/index.nix
      ./site/comics/index.nix
    ];

  in rec {

    result =
      map (f: { path = f.path;
                html = import f.data.template f.data; })
      (map (f: { path = builtins.replaceStrings [".nix"] [".html"] (builtins.substring 56 999 (toString f));
                 data = import f templates; })
      files);


    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "nix-to-html";

      system = builtins.currentSystem;

      src = ./.;  # Include source files in the derivation

      buildPhase = ''
        mkdir -p $out
        mkdir -p $out/comics
        echo "building files..."
        ${builtins.concatStringsSep "\n" (map (f: "echo '${f.html}' > $out/${f.path}") result)}
      '';

      installPhase = ''
        echo "Conversion completed. HTML files are in $out"
      '';
    };

  };


}