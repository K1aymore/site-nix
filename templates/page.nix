{ content, lang, ... }@inputs:



import ./parts/head.nix inputs + ''
</head>
<body class="${if lang == "sp" then "sitelen-pona" else ""}">

<div class="center-margin">
  <div class="center">
  ${content}
  </div>
</div>

'' + import ./parts/footer.nix inputs