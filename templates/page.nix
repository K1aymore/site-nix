{ content, lang ? "en", writ ? "", title, ... }@inputs:

let 
  contentClass = "content" +
    (if (writ == "-sp" || writ == "-jp" || writ == "-te") then " linebreaker" else "") +
    (if writ == "-te" then " tendrilis" else "");
in
''
${import ./parts/head.nix inputs}
<script src="/script.js"></script> 
</head>
<body>

<div id="centerMargin">
  ${import ./parts/navbar.nix inputs} 
  <div class="${contentClass}">
    <h1>
      ${title}
    </h1>
    <p>
      ${content}
    </p>
  </div>
</div>

${import ./parts/footer.nix inputs}


</body>
</html>
 ''