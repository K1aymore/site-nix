{ title, content, date, ... }@inputs:




import ./parts/header.nix inputs + ''

${content}

'' + import ./parts/footer.nix inputs