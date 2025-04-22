{ title, lang, path, langURL, getPathConverted, markdownConvert, sitelen-pona-UCSUR, tendrilis, ... }@inputs:

let
  dir = builtins.replaceStrings [ "index.html" ] [ "" ] (getPathConverted path);
  langPick = input: if lang == "tp"
    then sitelen-pona-UCSUR.ucsur2lasina input.tp-sp
    else if lang == "tp-jp"
    then sitelen-pona-UCSUR.ucsur2hiragana input.tp-sp
    else input.${lang};
  tendClass = if tendrilis then " tendrilis" else "";
  te = if tendrilis then "te/" else "";

  mkNavLink = { en, url ? en, ... }@langTitles:
  ''<a class="navLink${tendClass}" href="/${te}${langURL}/${url}">
      ${markdownConvert {inherit tendrilis; content = langPick langTitles;}}
    </a>'';
  
  mkLangLink = { lang, name }:
  ''
  '';

  tendrilisLink =
    if tendrilis then ''<a class="navLink" href="/${langURL}/${dir}">disable tendrilis</a>''
    else ''<a class="navLink tendrilis" href="/te/${langURL}/${dir}">tendrilis</a>'';
in
''
<nav id="navbar">
  <div class="navbarSection">
    <a class="navLink" href="/${te}${langURL}">klaymore.me</a>
  </div>
  <hr>
  <div class="navbarSection">
    ${mkNavLink { en = "home"; sv = "hem"; tp-sp = "󱥡󱥁"; url = ""; }}
    <!-- ${mkNavLink { en = "about"; sv = "om"; tp-sp = "󱥡󱥁"; }} -->
    ${mkNavLink { en = "blog"; sv = "blogg"; tp-sp = "󱥠󱥡"; }}
    ${mkNavLink { en = "comics"; sv = "webbserier"; tp-sp = "󱥠󱤪"; }}
    <!-- ${mkNavLink { en = "art"; sv = "konstverk"; tp-sp = "󱤪󱤻"; }} -->
  </div>
  <hr>
  <div class="navbarSection">
    <a class="navLink" href="/${te}en/${dir}">english</a>
    <a class="navLink" href="/${te}sv/${dir}">svenska</a>
    <ul>
      <input type="checkbox" id="tp-dropdown" />
      <label for="tp-dropdown" class="navLink">󱥬‍󱥔toki pona</label>
      <li value="toki pona"><a class="navLink" href="/${te}tp/${dir}">toki pona</a></li>
      <li value="󱥠‍󱥔"><a class="navLink" href="/${te}tp-sp/${dir}">󱥠‍󱥔</a></li>
      <li value="いらかな"><a class="navLink" href="/${te}tp-jp/${dir}">いらかな</a></li>
    </ul>
    ${tendrilisLink}
  </div>
</nav>
''