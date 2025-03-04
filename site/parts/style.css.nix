
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
      font-family: "nasin nanpa";
      src:
        local("nasin nanpa"),
        url('nasin-nanpa-4.0.2.otf') format('opentype');
      font-weight: lighter;
    }
    @font-face {
      font-family: "nasin nanpa ucsur";
      src:
        local("nasin nanpa ucsur"),
        url('nasin-nanpa-4.0.2-UCSUR.otf') format('opentype');
      font-weight: lighter;
    }
    .sp {
      font-family: "nasin nanpa";
    }
    .sitelen-pona {
      font-family: "sitelen seli kiwen asuki";
      font-size: 2rem !important;
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



    body {
      background-color: ${crust};
      color: ${text};
      font-size: 2em;
      font-family: "nasin nanpa ucsur", "sitelen seli kiwen juniko", serif;
    }

    #navbar {
      # background: ${mantle};
      align-items: center;
      justify-content: space-evenly;
      display: flex;
      flex-wrap: wrap;
    }

    #langbar {
      # background: ${mantle};
      align-items: center;
      justify-content: space-evenly;
      display: flex;
      flex-wrap: wrap;
    }

    #centerMargin {
      background: ${base};
      width: 97%;
      max-width: 30em;
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
