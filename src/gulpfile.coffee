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
  src:
    styles      : 'src/styles/**/*.stylus'
    images      : 'src/images/**/*'
    scripts     : 'src/scripts/**/*.coffee'
    nodeScripts : 'src/*.coffee'
  dest:
    styles      : 'assets/styles'
    images      : 'assets/images'
    scripts     : 'assets/scripts'
    nodeScripts : ''

gulp.task 'client-scripts', ->
  gulp.src(paths.src.scripts)
    .pipe(coffee())
    .pipe(uglify())
    .pipe(concat 'all.min.js')
    .pipe(gulp.dest paths.dest.scripts)

gulp.task 'node-scripts', ->
  gulp.src(paths.src.nodeScripts)
    .pipe(coffee bare: true)
    .pipe(gulp.dest paths.dest.nodeScripts)

gulp.task 'styles', ->
  gulp.src(paths.src.styles)
    .pipe(stylus())
    .pipe(gulp.dest paths.dest.styles)

gulp.task 'images', ->
  gulp.src(paths.src.images)
    .pipe(imagemin())
    .pipe(gulp.dest paths.dest.images)

gulp.task 'watch-client', ->
  gulp.watch paths.src.scripts, ['client-scripts', 'styles']

gulp.task 'watch-server', ->
  gulp.watch paths.src.nodeScripts, ['node-scripts']

gulp.task 'default', ['client-scripts', 'node-scripts', 'styles', 'images','watch-client', 'watch-server']
