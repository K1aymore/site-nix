{ title, lang, path, sitelen-pona-UCSUR, ... }@inputs:

let
  dir = builtins.replaceStrings [ "index.html" ] [ "" ] path;
  sitelen = lang == "tp-sp";
  langPick = input: if lang == "tp"
    then sitelen-pona-UCSUR.ucsur2lasina input.tp-sp or input.en
    else if lang == "tp-jp"
    then sitelen-pona-UCSUR.ucsur2hiragana input.tp-sp or input.en
    else input.${lang} or input.en;
in
''
<nav id="navbar">
  <div class="navbarSection">
    <a class="navLink" href="/${lang}">klaymore.me</a>
    <!-- <a class="navLink" href="/${lang}/about">
      ${langPick { en = "about"; sv = "om"; tp-sp = "󱥡󱥁"; }}
    </a> -->
    <a class="navLink" href="/${lang}/blog">
      ${langPick { en = "blog"; sv = "blogg"; tp-sp = "󱥠󱥡"; }}
    </a>
    <a class="navLink" href="/${lang}/comics">
      ${langPick { en = "comics"; sv = "webbserier"; tp-sp = "󱥠󱤪"; }}
    </a>
    <!-- <a class="navLink" href="/${lang}/art">
      ${langPick { en = "art"; sv = "konstverk"; tp-sp = "󱤪󱤻"; }}
    </a> -->

  </div>
  <div class="navbarSection">
    <a class="navLink" href="/en/${dir}">english</a>
    <a class="navLink" href="/sv/${dir}">svenska</a>
    <ul>
      <span class="navLink">󱥬‍󱥔toki pona</span>
      <li value="toki pona"><a class="navLink" href="/tp/${dir}">toki pona</a></li>
      <li value="󱥠‍󱥔"><a class="navLink" href="/tp-sp/${dir}">󱥠‍󱥔</a></li>
      <li value="いらかな"><a class="navLink" href="/tp-jp/${dir}">いらかな</a></li>
      <li value="안구"><a class="navLink" href="/tp-hg/${dir}">안구</a></li>
    </ul>
  </div>
</nav>
''