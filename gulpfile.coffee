gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'compile', ->
	gulp.src('src/**/*.coffee')
		.pipe coffee()
		.pipe gulp.dest('lib')

gulp.task 'example', ->
	trace = require './lib/index'
	gulp.src('example/src/**/*')
		.pipe trace()
		.pipe gulp.dest('example/dest')

gulp.task 'default', ['compile']