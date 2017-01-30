"use strict";

var path = require('path');
var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var sass = require('gulp-sass');

var config = require(path.join(__dirname, 'gulp-config.js'));

/*
* JavaScript Tasks
*/
gulp.task('concatScriptsAdmin', function(){
	return gulp.src(config.js.admin.app_files)
		.pipe(concat(config.js.admin.DIST_NAME + '.js'))
		.pipe(gulp.dest(config.js.admin.DEST_DIR));
});

gulp.task('minifyScriptsAdmin', ['concatScriptsAdmin'], function(){
	return gulp.src(path.join(config.js.admin.DEST_DIR, config.js.admin.DIST_NAME + '.js'))
		.pipe(uglify())
		.pipe(rename(config.js.admin.DIST_NAME + '.min.js'))
		.pipe(gulp.dest(config.js.admin.DEST_DIR));
});

gulp.task('concatScriptsPublic', function(){
	return gulp.src(config.js.public.app_files)
		.pipe(concat(config.js.public.DIST_NAME + '.js'))
		.pipe(gulp.dest(config.js.public.DEST_DIR));
});

gulp.task('minifyScriptsPublic', ['concatScriptsPublic'], function(){
	return gulp.src(path.join(config.js.public.DEST_DIR, config.js.public.DIST_NAME + '.js'))
		.pipe(uglify())
		.pipe(rename(config.js.public.DIST_NAME + '.min.js'))
		.pipe(gulp.dest(config.js.public.DEST_DIR));
});

/*
* Sass/Styles Tasks
*/
gulp.task('sass', function() {
    gulp.src(config.styles.SOURCE_DIR + '**/*.scss')
        .pipe(sass(config.styles.sass_options).on('error', sass.logError))
        .pipe(gulp.dest(config.styles.DEST_DIR));
});

/*
* Static Assets Tasks
*/
gulp.task('copyStaticAssets', function() {
    gulp.src(config.static_assets.SOURCE_DIR + '**/*', {base: config.static_assets.SOURCE_DIR})
        .pipe(gulp.dest(config.static_assets.DEST_DIR));
});


/*
* Watch tasks
*/

gulp.task('watchSass',function() {
    gulp.watch(config.styles.SOURCE_DIR + '**/*.scss', ['sass']);
});

gulp.task('watchScriptsAdmin', function(){
	gulp.watch(config.js.admin.SOURCE_DIR + '**/*.js', ['minifyScriptsAdmin']);
});

gulp.task('watchScriptsPublic', function(){
	gulp.watch(config.js.public.SOURCE_DIR + '**/*.js', ['minifyScriptsPublic']);
});

gulp.task('watchStaticAssets', function(){
	gulp.watch(config.static_assets.SOURCE_DIR + '**/*', ['copyStaticAssets']);
});


/*
* Main gulp tasks
*/
gulp.task('watch', ['build', 'watchSass', 'watchScriptsAdmin', 'watchScriptsPublic', 'watchStaticAssets']);
gulp.task('build', ['minifyScriptsAdmin', 'minifyScriptsPublic', 'sass', 'copyStaticAssets']);
gulp.task('default', ['build']);
