{ ... }:

let
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
    :root {
      --text: #cdd6f4;
      --subtext1: #bac2de;
      --subtext0: #a6adc8;
      --overlay2: #9399b2;
      --overlay1: #7f849c;
      --overlay0: #6c7086;
      --surface2: #585b70;
      --surface1: #45475a;
      --surface0: #313244;
      --base: #1e1e2e;
      --mantle: #181825;
      --crust: #11111b;

      --maroon: #eba0ac;
      --accent: var(--maroon);
    }


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
      font-family: "Tendrilis";
      src:
        local("Tendrilis"),
        url('Tendrilis-Regular.ttf') format('truetype');
    }


    .asuki {
      font-family: "sitelen seli kiwen asuki";
    }
    .linebreaker {
      text-indent: ${baseFontSize} hanging each-line;
    }
    .latin {
      font-family: "${baseFont}" !important;
    }
    .tendrilis {
      font-family: "Tendrilis" !important;
    }
    .hirWord {
      display: inline-block;
    }

    body {
      background-color: var(--crust);
      color: var(--text);
      font-size: ${baseFontSize};
      font-family: "${baseFont}", "sitelen seli kiwen juniko", sans-serif, serif;
    }



    a {
      color: var(--accent);
      text-decoration: none;
    }

    a:hover {
      color: var(--subtext1);
    }

    button {
      background: none;
      border: none;
      font-weight: bold;
      color: var(--text);
    }

    input {
      background: var(--surface0);
      border: none;
      color: var(--text);
    }



    

    hr {
      display: block;
      height: 1px;
      border: 0;
      border-top: 1px solid var(--overlay2);
      margin: 1rem 0;
      padding: 0;
    }

    #centerMargin {
      background: var(--base);
      width: fit-content;
      margin: auto;
      display: grid;
      grid-template-columns: minmax(min-content, 50rem);
      grid-auto-columns: min-content;
      grid-gap: 1rem;
      padding: 1rem;
    }

    .content {
      color: var(--text);
      text-align: left;
      overflow-wrap: break-word;
      max-width: 50rem;
    }


    @media (width >= 80rem) {
      #navbar {
        padding-top: 1.5rem;
      }
      #navbar .navbarSection {
        gap: 0rem;
        flex-direction: column;
      }
      #centerMargin {
        grid-template-columns: 17rem 50rem;
      }
    }


    #navbar {
      text-align: center;
      justify-content: space-around;
    }

    .navbarSection {
      justify-content: space-around;
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
    }

    .navLink {
      color: var(--accent);
      text-decoration: none;
    }
    .navLink:hover {
      color: var(--subtext1);
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
      text-align: center;
    }

    nav ul input[type="checkbox"] {
      position: absolute;
      left: 0;
      opacity: 0.01;
    }

    nav ul input[type="checkbox"]:checked ~ li {
      display: block;
    }



    .table {
      text-align: left;
      margin: 10%;
    }


  '';

}
