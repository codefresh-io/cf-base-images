#lifecycle "build" step
  #contributed from service "git"
  cd /opt/codefresh/cf-ide
  git pull origin editor-tabs
  
#lifecycle "run" step
  #contributed from service "cf-ide"
  cd /opt/codefresh/cf-ide/orionexpress
  node cli/fresh-cli.js -w /workspace -p 8081
  
