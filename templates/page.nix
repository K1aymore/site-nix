{ content, lang, ... }@inputs:


''
${import ./parts/head.nix inputs}

</head>
<body>

${import ./parts/navbar.nix inputs}


<div id="centerMargin">
  <div class="center${if lang == "tp-sp" then " sitelen-pona" else ""}">
  ${content}
  </div>
</div>

${import ./parts/footer.nix inputs}


</body>
</html>
 ''