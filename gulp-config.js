"use strict";

var path = require('path');
var config = {};

config.SOURCE_DIR = path.join(__dirname, 'web', 'static/');
config.DEST_DIR = path.join(__dirname, 'priv', 'static/');

/*
* JavaScript configuration
*/
config.js = {};

//admin configuration
config.js.admin = {};
config.js.admin.SOURCE_DIR = path.join(config.SOURCE_DIR, 'js/admin/');
config.js.admin.DEST_DIR = path.join(config.DEST_DIR, 'js/');
config.js.admin.DIST_NAME = 'admin'; //name of compiled file to be served i.e. app.js and app.min.js
config.js.admin.app_files = ['aquery', 'slugify', 'form_delete_button', 'autofill_image_name', 'add_tags', 'reorder_images', 'set_cover_image'];

//add source dir prefix and .js suffix to js source files
config.js.admin.app_files = config.js.admin.app_files.map(function(file){return path.join(config.js.admin.SOURCE_DIR, file + '.js');});

//public configuration
config.js.public = {};
config.js.public.SOURCE_DIR = path.join(config.SOURCE_DIR, 'js/public/');
config.js.public.DEST_DIR = path.join(config.DEST_DIR, 'js/');
config.js.public.DIST_NAME = 'app'; //name of compiled file to be served i.e. app.js and app.min.js
config.js.public.app_files = ['aquery', 'display_ablum'];

//add source dir prefix and .js suffix to js source files
config.js.public.app_files = config.js.public.app_files.map(function(file){return path.join(config.js.public.SOURCE_DIR, file + '.js');});


/*
* Sass/Styles configuration
*/
config.styles = {};
config.styles.SOURCE_DIR = path.join(config.SOURCE_DIR, 'css/');
config.styles.DEST_DIR = path.join(config.DEST_DIR, 'css/');
config.styles.sass_options = {
  errLogToConsole: true,
  // sourceComments: true, //turns on line number comments 
  outputStyle: 'compressed' //options: expanded, nested, compact, compressed
};

/*
* Static assets configuration
*/
config.static_assets = {};
config.static_assets.SOURCE_DIR = path.join(config.SOURCE_DIR, 'assets/');
config.static_assets.DEST_DIR = config.DEST_DIR;



/*
* Export config
*/
module.exports = config;