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
''
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
}''