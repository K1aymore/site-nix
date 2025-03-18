{ title, lang, path, sitelen-pona-UCSUR, ... }@inputs:

let
  dir = builtins.replaceStrings [ "index.html" ] [ "" ] path;
  sitelen = lang == "tp-sp";
  langPick = input: if lang == "tp"
    then sitelen-pona-UCSUR.ucsur2lasina input.tp-sp or input.en
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
    <a class="navLink" href="/en/${dir}">　english</a>
    <a class="navLink" href="/sv/${dir}">svenska</a>
    <ul>
      <a class="navLink" href="/tp/${dir}"><span class="tpDeco">󱥬‍󱥔</span>toki pona<span class="tpDeco">　</span></a>
      <li value="󱥠‍󱥔"><a class="navLink" href="/tp-sp/${dir}">󱥠‍󱥔</a></li>
      <li value="hangeul"><a class="navLink" href="/tp-hg/${dir}">한글</a></li>
    </ul>
  </div>
</nav>
''