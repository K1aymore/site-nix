{ title, lang ? "en", writ ? "", path, getDirNoLangs, markdownConvert, urlTo, sitelen-pona-UCSUR, ... }@inputs:

let

  dir = getDirNoLangs path;

  langPick = input: if lang == "tp" && writ == ""
    then sitelen-pona-UCSUR.ucsur2lasina input.tp-sp
    else if lang == "tp" && writ == "-jp"
    then sitelen-pona-UCSUR.ucsur2hiragana input.tp-sp
    else if lang == "tp" && writ == "-sp"
    then input.tp-sp
    else input.${lang} or input.en;

  class = if writ == "-te"
    then " tendrilis"
    else "";

  mkNavLink = { url ? "", ... }@langTitles:
  ''<a class="navLink${class}" href="${urlTo { inherit url lang writ; }}">
      ${markdownConvert { content = langPick langTitles; inherit writ; }}
    </a>'';
  

in
''
<nav id="navbar">
  <div class="navbarSection">
    <a class="navLink" href="${urlTo { url = "/"; inherit lang writ; }}">klaymore.me</a>
  </div>
  <hr>
  <div class="navbarSection">
    ${mkNavLink { url = "/"; en = "home"; sv = "hem"; tp-sp = "󱥡󱥁"; }}
    <!-- ${mkNavLink { url = "/about/"; en = "about"; sv = "om"; tp-sp = "󱥡󱥁"; }} -->
    ${mkNavLink { url = "/blog/"; en = "blog"; sv = "blogg"; tp-sp = "󱥠󱥡"; }}
    ${mkNavLink { url = "/comics/"; en = "comics"; sv = "webbserier"; tp-sp = "󱥠󱤪"; }}
    ${mkNavLink { url = "/things-to-read/"; en = "things to read"; sv = "saker att läsa"; tp-sp = "󱥄󱤮󱤉󱤪󱤆"; }}
    <!-- ${mkNavLink { url = "/art/"; en = "art"; sv = "konstverk"; tp-sp = "󱤪󱤻"; }} -->
  </div>
  <hr>
  <div id="navLangs" class="navbarSection">
    <ul>
      <li value="english"><a class="navLink" href="${urlTo { lang = "en"; url = dir; }}">english</a></li>
      <li value="english tendrilis"><a class="navLink tendrilis" href="${urlTo { lang = "en"; writ = "-te"; url = dir; }}">en</a></li>
    </ul><ul>
      <li value="svenska"><a class="navLink" href="${urlTo { lang = "sv"; url = dir; }}">svenska</a></li>
      <li value="svenska tendrilis"><a class="navLink tendrilis" href="${urlTo { lang = "sv"; writ = "-te"; url = dir; }}">sv</a></li>
    </ul><ul>
      <li value="toki pona"><a class="navLink" href="${urlTo { lang = "tp"; url = dir; }}">toki pona</a></li>
      <li value="󱥠‍󱥔"><a class="navLink" href="${urlTo { lang = "tp"; writ = "-sp"; url = dir; }}">󱥠‍󱥔</a></li>
      <li value="いらかな"><a class="navLink" href="${urlTo { lang = "tp"; writ = "-jp"; url = dir; }}">いらかな</a></li>
      <li value="toki pona tendrilis"><a class="navLink tendrilis" href="${urlTo { lang = "tp"; writ = "-te"; url = dir; }}">tp</a></li>
    </ul>
  </div>
</nav>
''