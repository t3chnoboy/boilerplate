gulp       = require 'gulp'
gutil      = require 'gulp-util'
mocha      = require 'gulp-mocha'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
imagemin   = require 'gulp-imagemin'
livereload = require 'gulp-livereload'

paths =
  images      : ''
  styles      : ''
  scripts     : ['src/scripts/**/*.coffee']
  nodeScripts : ['src/*.coffee']

gulp.task 'client-scripts', ->
  gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(uglify())
    .pipe(concat('all.min.js'))
    .pipe(gulp.dest('assets/scripts'))

gulp.task 'node-scripts', ->
  gulp.src(paths.nodeScripts)
    .pipe(coffee(bare: true))
    .pipe(gulp.dest(''))

gulp.task 'watch-client', ->
  gulp.watch paths.scripts, ['client-scripts']

gulp.task 'watch-server', ->
  gulp.watch paths.nodeScripts, ['node-scripts']

gulp.task 'default', ['client-scripts', 'node-scripts', 'watch-client']
