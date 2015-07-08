gulp = require 'gulp'
coffee = require 'gulp-coffee'
browserSync = require 'browser-sync'
less = require 'gulp-less'
gulp.task 'coffee', () ->
    gulp.src 'coffee/*.coffee'
        .pipe coffee()
        .pipe gulp.dest('./js')

gulp.task 'less', () ->
    gulp.src 'less/*.less'
        .pipe less()
        .pipe gulp.dest('./css')

gulp.task 'watch',()->
  gulp.watch './coffee/*.coffee',['coffee']
  gulp.watch './less/*.less',['less']

gulp.task 'serve',() ->
  browserSync
    notify: false
    logPrefix: 'IDI'
    server: './'

gulp.task 'default',['watch','serve']
