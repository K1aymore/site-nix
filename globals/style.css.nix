{ ... }:

let
  text = "#cdd6f4";
  subtext1 = "#bac2de";
  subtext0 = "#a6adc8";
  overlay2 = "#9399b2";
  overlay1 = "#7f849c";
  overlay0 = "#6c7086";
  surface2 = "#585b70";
  surface1 = "#45475a";
  surface0 = "#313244";
  base = "#1e1e2e";
  mantle = "#181825";
  crust = "#11111b";

  maroon = "#eba0ac";
  accent = maroon;

  baseFont = "sitelen seli kiwen juniko";
  baseFontSize = "1.65rem";
in
{

  # sitelen pona fonts
  # nasin-nanpa: very complete. hard to read. kala eyes
  # linja-pona: mi symbol looks bad. no kala eyes
  # FairfaxPonaHD: looks pretty nice (slightly stretched vertically). kala eyes
  # sitelen-seli-kiwen-asuki: not as crisp. most readable cartouches. kala eyes
  # nishiki-teki-lili: thicker than sitelen-seli. nice cartouches. kala eyes
  # nishiki-teki-lili-pi-pss: same but more space around punctuation. kala eyes
  # sitelen-Antowi: doesn't work? no kala eyes


    # floating vertical sidebar
    # @media (width >= 90rem) {
    #   #navbar {
    #     position: fixed;
    #     height: auto;
    #     right: 10%;
    #     top: 25%;
    #     width: auto;
    #     flex-direction: column;
    #     padding: 1rem 2rem;
    #   }
    #   .navbarSection {
    #     flex-direction: column;
    #   }
    # }


  content = ''
    @font-face {
      font-family: "sitelen seli kiwen asuki";
      src:
        local("sitelen seli kiwen asuki"),
        url('sitelen-seli-kiwen-asuki.ttf') format('truetype');
    }
    @font-face {
      font-family: "sitelen seli kiwen juniko";
      src:
        local("sitelen seli kiwen juniko"),
        url('sitelen-seli-kiwen-juniko.ttf') format('truetype');
    }
    @font-face {
      font-family: "sitelen seli kiwen mono juniko";
      src:
        local("sitelen seli kiwen mono juniko"),
        url('sitelen-seli-kiwen-mono-juniko.ttf') format('truetype');
    }
    @font-face {
      font-family: "Ownglyph Berry RW";
      src:
        local("Ownglyph Berry RW"),
        url('Ownglyph-Berry-RW.ttf') format('truetype');
    }


    .asuki {
      font-family: "sitelen seli kiwen asuki";
    }
    .sitelen-pona {
      font-family: "sitelen seli kiwen juniko";
      text-indent: ${baseFontSize} hanging each-line;
    }
    .latin {
      font-family: "${baseFont}" !important;
    }

    body {
      background-color: ${crust};
      color: ${text};
      font-size: ${baseFontSize};
      font-family: "${baseFont}", "sitelen seli kiwen juniko", "Ownglyph Berry RW", serif;
    }



    a {
      color: ${accent};
      text-decoration: none;
    }

    a:hover {
      color: ${subtext1};
    }

    button {
      background: none;
      border: none;
      font-weight: bold;
      color: ${text};
    }

    input {
      background: ${surface0};
      border: none;
      color: ${text};
    }



    #navbar {
      background: ${base};
      width: 97%;
      max-width: 50rem;
      margin: auto;
    }

    .navbarSection {
      justify-content: space-evenly;
      display: flex;
      flex-wrap: wrap;
    }

    nav ul {
      list-style: none;
      margin: 0;
      padding: 0;
      justify-content: center;
      display: inline-block;
    }

    nav ul li {
      display: none;
    }

    nav ul:hover li {
      display: block;
      text-align: center;
    }

    nav ul:hover .tpDeco {
      visibility: hidden;
    }




    hr {
      display: block;
      height: 1px;
      border: 0;
      border-top: 1px solid ${overlay1};
      margin: 1rem 0;
      padding: 0;
    }

    #centerMargin {
      background: ${base};
      width: 97%;
      max-width: 50rem;
      margin: auto;
    }

    .content {
      text-align: left;
      color: ${text};
      padding-top: 1%;
      padding-left: 4%;
      padding-right: 4%;
      padding-bottom: 1%;
    }

    .table {
      text-align: left;
      margin: 10%;
    }
  '';

}
