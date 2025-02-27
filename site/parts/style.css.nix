templates:

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
  accent-color = maroon;
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
      font-family: sitelen-seli-kiwen-asuki;
      src: url('sitelen-seli-kiwen-asuki.ttf') format('truetype');
      font-weight: lighter;
      font-style: normal;
    }
    .sitelen-pona {
      font-family: sitelen-seli-kiwen-asuki;
      font-size: 1.7rem;
    }

    body {
      background-color: ${mantle};
      color: ${text};
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
      font-size: 1em;
    }

    .centerMargin {
      width: 60%;
      margin: auto;
      background: ${base};
    }

    .center {
      text-align: left;
      margin: 3%;
      color: ${text};
      font-size: 1.05em;
    }

    .table {
      text-align: left;
      margin: 10%;
    }
  '';

}
