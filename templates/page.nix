{ content, lang ? "en", writ ? "", title, vert, ... }@inputs:

let 
  linebreakerClass = if vert
    then " linebreaker"
    else "";
in
''
${import ./parts/head.nix inputs}
<script src="/script.js"></script> 
</head>
<body>

<div id="centerMargin" class="${linebreakerClass}">
  ${import ./parts/navbar.nix inputs} 
  <main class="content${linebreakerClass}${if writ == "-te" then " tendrilis" else ""}">
    <h1>
      ${title}
    </h1>
    <p>
      ${content}
    </p>
  </main>
</div>

${import ./parts/footer.nix inputs}


</body>
</html>
''