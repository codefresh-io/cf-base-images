#lifecycle "build" step
  #contributed from service "git"
  cd /opt/codefresh/cf-ide
  git pull origin orion-v8
  
#lifecycle "run" step
  #contributed from service "cf-ide"
  cd /opt/codefresh/cf-ide/orionexpress
  node cli/fresh-cli.js -w /workdir -p 8081
  
