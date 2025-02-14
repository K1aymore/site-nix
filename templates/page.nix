{ content, ... }@inputs:




import ./parts/header.nix inputs + ''

${content}

'' + import ./parts/footer.nix inputs