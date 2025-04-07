{ content, lang, title, tendrilis, ... }@inputs:

let 
  contentClass = "content" +
    (if (lang == "tp-sp" || lang == "tp-jp" || tendrilis) then " linebreaker" else "") +
    (if tendrilis then " tendrilis" else "");
in
''
${import ./parts/head.nix inputs}

</head>
<body>

<div id="centerMargin">
  ${import ./parts/navbar.nix inputs} 
  <div class="${contentClass}">
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