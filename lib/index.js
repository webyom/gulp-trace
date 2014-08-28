(function() {
  var EOL, gutil, path, through;

  path = require('path');

  gutil = require('gulp-util');

  through = require('through2');

  EOL = '\n';

  module.exports = function(opt) {
    if (opt == null) {
      opt = {};
    }
    return through.obj(function(file, enc, next) {
      var trace;
      if (file.isNull()) {
        return this.emit('error', new gutil.PluginError('gulp-trace', 'File can\'t be null'));
      }
      if (file.isStream()) {
        return this.emit('error', new gutil.PluginError('gulp-trace', 'Streams not supported'));
      }
      if (path.extname(file.path) === '.html') {
        trace = '<!-- trace:' + path.relative(process.cwd(), file.path) + ' -->' + EOL;
      } else if (path.extname(file.path) === '.coffee') {
        trace = '### trace:' + path.relative(process.cwd(), file.path) + ' ###' + EOL;
      } else {
        trace = '/* trace:' + path.relative(process.cwd(), file.path) + ' */' + EOL;
      }
      file.contents = new Buffer(trace + file.contents.toString());
      this.push(file);
      return next();
    });
  };

}).call(this);
