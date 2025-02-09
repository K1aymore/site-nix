{

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = { self, nixpkgs, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    config = {
      templates = ./templates;
      lang = "sv";
    };

    files = [
      ./site/index.nix
      ./site/comics/index.nix
    ];

  in rec {

    result =
      (map (f: { path = builtins.replaceStrings [".nix"] [".html"] (builtins.substring 56 999 (toString f)); html = import f { inherit config; }; }) 
      files);

    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "nix-to-html";

      system = "x86_64-linux";
      nativeBuildInputs = [ pkgs.bash pkgs.nix ];

      src = ./.;  # Include source files in the derivation

      buildPhase = ''
        mkdir -p $out
        mkdir -p $out/comics
        echo "building files..."
        ${nixpkgs.lib.concatStringsSep "\n" (map (f: "echo '${f.html}' > $out/${f.path}") result)}
      '';

      installPhase = ''
        echo "Conversion completed. HTML files are in $out"
      '';
    };

  };


}