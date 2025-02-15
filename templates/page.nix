{ content, ... }@inputs:



import ./parts/head.nix inputs + ''
</head>
<body class="linja-ponja">
${content}

'' + import ./parts/footer.nix inputs