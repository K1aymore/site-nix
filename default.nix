{
  pkgs ? import <nixpkgs> {}
}:

pkgs.stdenv.mkDerivation {
  name = "example";
  src = ./.;
  buildInputs = [ pkgs.bash ];  # Ensure Bash is included
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out
    echo "Building..."
    echo "Hello, world!" > $out/message.txt
  '';
}