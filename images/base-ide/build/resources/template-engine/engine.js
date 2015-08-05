var Q = require('q');

function pathExists(path) {
    return Q.ninvoke(fs, 'stat', path)
        .then(function () {
            return true;
        },
        function (err) {
            if (err.code === 'ENOENT') {
                return false;
            }
            else {
                throw new Error ('failed to determine existance of file ' + path + ', error:' + err.stack);
            }
        });
}

function assertPathExists(path) {
    return pathExists(path)
        .then(function(existance) {
            if (!existance) {
                throw new Error('no such path ' + path);
            }
        });
}

function formatFolder(folderPath, data) {

    return assertPathExists(folderPath)
        .then(function () {

            var deferred = Q.defer();
            var promises = [];

            filewalker(folderPath)
                .on('file', function(relativePathToFile) {

                    var pathToFile = path.resolve(folderPath, relativePathToFile);

                    var processFilePromise = readFile(pathToFile, 'utf8')
                        .then(function (fileString) {
                            //replace {{var}} in fileString according to bindings in data
                            return swig.render(fileString, {locals: data});
                        })
                        .then(function (replacedString) {
                            return writeFile(pathToFile, replacedString, 'utf8');
                        })
                        .catch(function (err) {
                            console.error(err + err.stack);
                        });

                    promises.push(processFilePromise);
                })
                .on('error', function(err) {
                    deferred.reject(err);
                })
                .on('done', function() {
                    Q.all(promises).done(
                        deferred.resolve.bind(deferred),
                        deferred.reject.bind(deferred));
                })
                .walk();

            return deferred.promise;
        });
}

module.exports = formatFolder;
