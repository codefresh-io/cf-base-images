var interpolate = require('./engine.js');

if (process.argv.length < 3) {
  console.error('1 argument expected: path to folder');
  process.exit(1);
}

var path = process.argv[2];

interpolate(path, process.env)
  .done(
    console.log.bind(console, 'folder interpolated successfully.'),
    console.log.bind(console, 'folder failed to interpolate.'));
