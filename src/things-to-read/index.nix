{ ... }:

let
  mkLink = text: ''<a\ href="https://${text}">${text}</a>'';
in
{

  title = "Things to Read";

  date = "2025-04-28";

  en = 
  ''Here are some other websites I think are cool:
    <ul>
      <li>${mkLink "xkcd.com"}</li>
      <li>${mkLink "zamundaaa.github.io"}</li>
      <li>${mkLink "xeiaso.net/blog"}</li>
      <li>${mkLink "www.supergoodcode.com"}</li>
      <li>${mkLink "solar.lowtechmagazine.com"}</li>
      <li><a\ href="https://juuso.dev/blogPosts/nix-as-a-static-site-generator/nix-as-a-static-site-generator.html">juuso.dev</a></li>
      <li>${mkLink "fzakaria.com"}</li>
      <li><a\ href="https://isabelroses.com/blog/im-not-mad-im-disappointed">isabelroses.com</a></li>
      <li>${mkLink "blog.vladzahorodnii.com"}</li>
      <li><a\ href="https://rosenzweig.io/blog/vk13-on-the-m1-in-1-month.html">rosenzweig.io</a></li>
    </ul>
  '';

  sv = 
  ''Här är några andra webbsidor jag tycker om:
    <ul>
      <li>${mkLink "xkcd.com"}</li>
      <li>${mkLink "zamundaaa.github.io"}</li>
      <li>${mkLink "xeiaso.net/blog"}</li>
      <li>${mkLink "www.supergoodcode.com"}</li>
      <li>${mkLink "solar.lowtechmagazine.com"}</li>
      <li><a\ href="https://juuso.dev/blogPosts/nix-as-a-static-site-generator/nix-as-a-static-site-generator.html">juuso.dev</a></li>
      <li>${mkLink "fzakaria.com"}</li>
      <li><a\ href="https://isabelroses.com/blog/im-not-mad-im-disappointed">isabelroses.com</a></li>
      <li>${mkLink "blog.vladzahorodnii.com"}</li>
      <li><a\ href="https://rosenzweig.io/blog/vk13-on-the-m1-in-1-month.html">rosenzweig.io</a></li>
    </ul>
  '';
  
  tp =
  ''󱤪󱤆󱥍󱥔󱥩󱤴󱦝
    <ul>
      <li>${mkLink "xkcd.com"}</li>
      <li>${mkLink "zamundaaa.github.io"}</li>
      <li>${mkLink "xeiaso.net/blog"}</li>
      <li>${mkLink "www.supergoodcode.com"}</li>
      <li>${mkLink "solar.lowtechmagazine.com"}</li>
      <li><a\ href="https://juuso.dev/blogPosts/nix-as-a-static-site-generator/nix-as-a-static-site-generator.html">juuso.dev</a></li>
      <li>${mkLink "fzakaria.com"}</li>
      <li><a\ href="https://isabelroses.com/blog/im-not-mad-im-disappointed">isabelroses.com</a></li>
      <li>${mkLink "blog.vladzahorodnii.com"}</li>
      <li><a\ href="https://rosenzweig.io/blog/vk13-on-the-m1-in-1-month.html">rosenzweig.io</a></li>
    </ul>
  '';

}
