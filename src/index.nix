{ templates, ... }:

{

  template = templates.page;

  title = "Home";

  date = "2025-02-07";

  en =
  ''<img class="pixelated" src="/parts/profile.png">

    Welcome to my website!

    My website has gone through a couple iterations every time I come back to it. This version is built using a little static site generator (written in Nix) I've been working on <a href="https://github.com/K1aymore/site-nix">here</a>. I have nothing to put on this site and probably never will but it's cool to have one.

    I like
    <ul id="interestsList">
      <li>NixOS</li>
      <li>Arcane</li>
      <li>logging everything</li>
      <li>languages apparently</li>
      <li>NixOS</li>
      <li>Catppuccin</li>
    </ul>
    <button onclick="sortList()"> 
      Shuffle List
    </button>
  '';

  sv =
  ''Det här är min webbsida waow

    Violettkronad amazon[2] (Amazona finschi) är en starkt utrotningshotad papegojfågel som är endemisk för Mexiko.[3]

    Violettkronad amazon är en 30,5–34,5 cm lång papegoja med lysande grön fjäderdräkt, rött på pannan och violett på hjässa och halssidor. Handpennorna är spetsade i blåviolett och på de yttre armpennorna syns en röd fläck. Näbben är ljust hornfärgad och benen ljusgrå. Bland de olika hesa lätena hörs gälla "krih-krih", rullande "krreeeih", ett mörkare "kyah'ha" och ett nästan korplikt "krra krra".
    
    == >= =>
  '';
  
  tp =
  ''󱤑󱦐Sitata󱦑󱤧󱥖󱥴󱤃󱤧󱥔󱤮󱤧󱤑󱤨󱥍󱤑󱥡󱥚
    󱥆󱤊󱤑󱥖󱦐Kowinta󱦑󱥍󱤑󱥡󱥚󱤆󱤧󱤖󱥣󱤬󱥏󱥭, 󱤬󱥤󱥍󱥪󱤩, 󱤬󱥒󱥍󱥭󱥩󱥪, 󱤬󱥏󱥍󱤰󱤗󱦐Sawa󱦑, 󱤬󱥏󱥍󱤗󱤚
    󱤑󱦐Sitata󱦑󱤧󱤬󱥪󱤡󱥆󱤧󱥌󱥚󱤧󱥪󱤉󱥛󱤙󱤿󱥚
    󱥤󱤧󱥏󱤨󱤉󱥘󱥲󱥆
    󱤑󱦐Sitata󱦑󱤧󱤬󱤰󱤗󱤚󱤡󱤗󱤧󱥏󱤉󱤮󱥆
    󱥆󱤧󱤻󱤧󱤠󱤉󱤕󱥍󱤱󱤳󱥆
    󱥆󱤧󱤿󱥚󱤧󱤠󱤉󱥬󱥍󱤱󱥡󱥆

    󱤔'';
  
}
