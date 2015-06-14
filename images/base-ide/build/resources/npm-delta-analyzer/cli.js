//usage: install /tmp/cf/branch_compare/package.json.old /tmp/cf/branch_compare/package.json.new

var _ = require('lodash');

if (process.argv.length < 5) {
  console.error('3 arguments expected: command (install/uninstall, old package.json path, new package.json path');
  process.exit(1);
}

var cmd = process.argv[2];
var oldFilePath = process.argv[3];
var newFilePath = process.argv[4];

var oldPackageJson = require(oldFilePath);
var newPackageJson = require(newFilePath);

//TODO: support uninstall
if (cmd === "install") {

  //TODO: dev dependencies
  var newModules = _.difference(_.keys(newPackageJson.dependencies), _.keys(oldPackageJson.dependencies));
  var newModulesWithVersions = _.map(newModules, function (moduleName) {
    return moduleName + '@' + newPackageJson.dependencies[moduleName];
  });

  console.log(newModulesWithVersions.join(' '));
}
else {
  console.error('unknown instruction: ' + cmd);
  process.exit(1);
}
