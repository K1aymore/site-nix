{ title, lang ? "en", path, getFileNameConverted, markdownConvert, sitelen-pona-UCSUR, tendrilis, ... }@inputs:

let
  dir = builtins.replaceStrings [ "index.html" ] [ "" ] (getFileNameConverted path);
  langPick = input: if lang == "tp"
    then sitelen-pona-UCSUR.ucsur2lasina input.tp-sp
    else if lang == "tp-jp"
    then sitelen-pona-UCSUR.ucsur2hiragana input.tp-sp
    else input.${lang};

  mkNavLink = { en, url ? en, ... }@langTitles:
  ''<a class="navLink" href="/${url}">
      ${markdownConvert {inherit tendrilis; content = langPick langTitles;}}
    </a>'';
  

in
''
<nav id="navbar">
  <div class="navbarSection">
    <a class="navLink" href="/">klaymore.me</a>
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
    <ul>
      <li value="english"><a class="navLink" href="/en/${dir}">english</a></li>
      <li value="english tendrilis"><a class="navLink tendrilis" href="/en-te/${dir}">en</a></li>
    </ul><ul>
      <li value="svenska"><a class="navLink" href="/sv/${dir}">svenska</a></li>
      <li value="svenska tendrilis"><a class="navLink tendrilis" href="/sv-te/${dir}">sv</a></li>
    </ul><ul>
      <li value="toki pona"><a class="navLink" href="/tp/${dir}">toki pona</a></li>
      <li value="󱥠‍󱥔"><a class="navLink" href="/tp-sp/${dir}">󱥠‍󱥔</a></li>
      <li value="いらかな"><a class="navLink" href="/tp-jp/${dir}">いらかな</a></li>
      <li value="toki pona tendrilis"><a class="navLink tendrilis" href="/tp-te/${dir}">tp</a></li>
    </ul>
  </div>
</nav>
''