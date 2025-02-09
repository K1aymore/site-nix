{ title, content, date }:




import ./parts/header.nix title + ''


${content}


'' + import ./parts/footer.nix {}