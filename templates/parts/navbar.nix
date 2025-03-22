{ title, lang, path, getPathConverted, sitelen-pona-UCSUR, tendrilis, ... }@inputs:

let
  dir = builtins.replaceStrings [ "index.html" ] [ "" ] (getPathConverted path);
  sitelen = lang == "tp-sp";
  langPick = input: if lang == "tp"
    then sitelen-pona-UCSUR.ucsur2lasina input.tp-sp or input.en
    else if lang == "tp-jp"
    then sitelen-pona-UCSUR.ucsur2hiragana input.tp-sp or input.en
    else input.${lang} or input.en;
  tend = if tendrilis then " tendrilis" else "";
  te = if tendrilis then "te/" else "";

  mkNavLink = { en, ... }@langTitles:
  ''<a class="navLink${tend}" href="/${te}${lang}/${en}">
      ${langPick langTitles}
    </a>'';
in
''
<nav id="navbar">
  <div class="navbarSection">
    <a class="navLink" href="/${lang}">klaymore.me</a>
    <!--
    ${mkNavLink { en = "about"; sv = "om"; tp-sp = "󱥡󱥁"; }}
    -->
    ${mkNavLink { en = "blog"; sv = "blogg"; tp-sp = "󱥠󱥡"; }}
    ${mkNavLink { en = "comics"; sv = "webbserier"; tp-sp = "󱥠󱤪"; }}
    <!--
    ${mkNavLink { en = "art"; sv = "konstverk"; tp-sp = "󱤪󱤻"; }}
    -->

  </div>
  <div class="navbarSection">
    <a class="navLink" href="/${te}en/${dir}">english</a>
    <a class="navLink" href="/${te}sv/${dir}">svenska</a>
    <ul>
      <span class="navLink">󱥬‍󱥔toki pona</span>
      <li value="toki pona"><a class="navLink" href="/${te}tp/${dir}">toki pona</a></li>
      <li value="󱥠‍󱥔"><a class="navLink" href="/tp-sp/${dir}">󱥠‍󱥔</a></li>
      <li value="いらかな"><a class="navLink" href="/tp-jp/${dir}">いらかな</a></li>
      <li value="안구"><a class="navLink" href="/tp-hg/${dir}">안구</a></li>
    </ul>
  </div>
</nav>
''