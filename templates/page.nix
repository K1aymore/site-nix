{ content, lang, title, ... }@inputs:


''
${import ./parts/head.nix inputs}

</head>
<body>

${import ./parts/navbar.nix inputs}

<div id="centerMargin">
  <div class="content${if lang == "tp-sp" then " sitelen-pona" else ""}">
    <h3>
      ${title}
    </h3>
    <p>
      ${content}
    </p>
  </div>
</div>

${import ./parts/footer.nix inputs}


</body>
</html>
 ''