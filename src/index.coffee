path = require 'path'
gutil = require 'gulp-util'
through = require 'through2'

EOL = '\n'

module.exports = (opt = {}) ->
	through.obj (file, enc, next) ->
		return @emit 'error', new gutil.PluginError('gulp-trace', 'File can\'t be null') if file.isNull()
		return @emit 'error', new gutil.PluginError('gulp-trace', 'Streams not supported') if file.isStream()
		if path.extname(file.path) is '.html'
			trace = '<!-- trace:' + path.relative(process.cwd(), file.path) + ' -->' + EOL
		else if path.extname(file.path) is '.coffee'
			trace = '### trace:' + path.relative(process.cwd(), file.path) + ' ###' + EOL
		else
			trace = '/* trace:' + path.relative(process.cwd(), file.path) + ' */' + EOL
		file.contents = new Buffer(trace + file.contents.toString())
		@push file
		next()
