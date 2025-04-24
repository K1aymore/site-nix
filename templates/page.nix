{ content, lang ? "en", title, tendrilis, ... }@inputs:

let 
  contentClass = "content" +
    (if (lang == "tp-sp" || lang == "tp-jp" || tendrilis) then " linebreaker" else "") +
    (if tendrilis then " tendrilis" else "");
in
''
${import ./parts/head.nix inputs}
<script src="/parts/script.js"></script> 
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