{ ... }:

{

  title = "Home";

  date = "2025-02-07";

  en =
  ''<img class="pixelated" src="/profile.png">

    Welcome to my website!

    This site has gone through a couple different iterations over the years. This version is built using a little static site generator (written in Nix) I've been working on <a href="https://github.com/K1aymore/site-nix">here</a>. I have nothing of interest to put on this site but it's cool to have one.

    I like
    <ul\ id="interestsList">
      <li>NixOS</li>
      <li>Arcane</li>
      <li>logging everything</li>
      <li>languages, apparently</li>
      <li>NixOS</li>
      <li>Catppuccin</li>
    </ul>
    <button\ onclick="sortList()">
      Shuffle List
    </button>

    For keyboard access, use the up arrow and the down arrow to scroll up and down, and use tab and shift-tab to select links and buttons, then enter to interact with the selected item.

    The navbar is set as a nav element, and the content area here is a main element. The navbar receives keyboard input before the content. There is visibility from the selection outline, feedback as it moves, constraints and mapping of only using tab and shift-tab to navigate the whole site, and consistency that shift-tab undoes the effects of tab.
  '';

  sv =
  ''<img class="pixelated" src="/profile.png">

    Välkommen till min webbplats waow

    Jag har gjort om den här webbplatsen några gånger. Den här version använder en static site generator jag jobbar på <a href="https://github.com/K1aymore/site-nix">här</a>, som jag skriver på Nix. Det finns ingenting som intresser här men det är kul att ha en webbplats.

    Jag tycker om
    <ul\ id="interestsList">
      <li>NixOS</li>
      <li>Arcane</li>
      <li>anteckna allting</li>
      <li>språk, tydligen</li>
      <li>NixOS</li>
      <li>Catppuccin</li>
    </ul>
    <button\ onclick="sortList()">
      Blanda Listan
    </button>
  '';
  
  tp =
  ''<img class="pixelated" src="/profile.png">

    󱤖󱥔󱥩󱤪󱤴

    󱤴󱤆󱤉󱤪󱥁󱤬󱥫󱤼󱦜
    󱥫󱥁󱤡󱤴󱥉󱤉<a href="https://github.com/K1aymore/site-nix">󱤎</a>󱥍󱥉󱤪󱤙󱥬󱦐Nix󱦑󱦜
    󱤎󱥉󱤧󱥉󱤉󱤪󱥁󱦜
    󱤪󱥁󱤧󱥓󱤂󱤉󱤌󱥣󱥨󱤧󱥔󱥩󱤴󱦜

    󱥁󱤧󱥔󱥩󱤴󱦝
    <ul\ id="interestsList">
      <li>󱤎󱤤󱦐NixOS󱦑</li>
      <li>󱤻󱦐Arcane󱦑</li>
      <li>󱥠󱥍󱥡󱤴</li>
      <li>󱥬󱤆</li>
      <li>󱤎󱤤󱦐NixOS󱦑</li>
      <li>󱤞󱤟󱦐Catppuccin󱦑</li>
    </ul>
    <button\ onclick="sortList()">
      󱥄󱤆󱤉󱤩󱥠
    </button>
  '';
  
}
