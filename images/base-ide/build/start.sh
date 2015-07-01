
#lifecycle "run" step
  #contributed from service "cf-ide"
  cd /opt/codefresh/cf-ide/orionexpress
  node cli/fresh-cli.js -w /workdir -p 8081

