{ title, lang, path, ... }@inputs:

let
  dir = builtins.replaceStrings [ "/index.html" ] [ "/" ] path;
in
''
<div id="navbar">

  <a class="navLink" href="/${lang}">klaymore.me</a>
  <a class="navLink" href="/${lang}/about">about</a>
  <a class="navLink" href="/${lang}/blog">blog</a>
  <a class="navLink" href="/${lang}/comics">comics</a>

</div>
<div id="langbar">

  <a class="navLink" href="/en/${dir}">english</a>
  <a class="navLink" href="/sv/${dir}">svenska</a>
  <a class="navLink" href="/tp/${dir}">󱥬‍󱥔toki pona</a>
  <a class="navLink" href="/tp-sp/${dir}">󱥠󱥔sitelen pona</a>

</div>
''