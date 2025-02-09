{ config }:

let 
	title = "Main";

	content = if config.lang == "en" then
		"Welcome to my site!" else
		"Välkommen till min webbsida!";
	
	date = 2025-02-07;
in

import (config.templates + /page.nix) { inherit title content date; }