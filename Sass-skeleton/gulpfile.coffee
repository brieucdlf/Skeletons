# Configuration variables
path =
	css: 'public/css/'
	scss: 'public/css/'
	img: 'public/img/'

# Require
gulp = require('gulp')
browserSync = require('browser-sync')
$ = require('gulp-load-plugins')()

# Tasks
# Sass Task To compile sass to css
gulp.task 'sass', ->
	gulp.src "#{path.scss}*.scss"
	.pipe $.sass().on('error', $.sass.logError)
	.pipe $.autoprefixer
		browsers: ["chrome 53", "chrome 52", "edge 14", "firefox 49","ie 11", "ie_mob 11", "ios_saf 10", "opera 39", "safari 10"]
	.pipe gulp.dest path.css
	.pipe $.size()
	.pipe browserSync.reload(stream: true)

# Sprites to retina
gulp.task 'copyNonRetina', ->
	dest = "#{path.img}icons"
	gulp.src "#{path.img}icons/@2x/*.png"
	.pipe $.changed dest
	.pipe $.imageResize {width: '50%', height: '50%', imageMagick: true}
	.pipe gulp.dest dest

# Sprites Task compiler
gulp.task 'sprite', ['copyNonRetina'], ->
	options = {optimizationLevel: 5, progressive:true, interlace: true}
	gulp.src "#{path.img}icons/@2x/*.png"
	.pipe $.spritesmith {imgName: "sprite@2x.png", cssName: "_sprite.scss"}
	.img.pipe($.imagemin(options)).pipe gulp.dest path.img

	sprite = gulp.src "#{path.img}icons/*.png"
	.pipe $.spritesmith
		imgName: 'sprite.png',
		cssName: '_sprite.scss',
		cssVarMap: (sprite) ->
			sprite.spritename = sprite.image.replace ".png", ""
			return sprite
		cssTemplate: "{#{path.scss}'tools/_sprite.scss.handlebars"

	sprite.img.pipe($.imagemin(options)).pipe gulp.dest path.img
	sprite.css.pipe gulp.dest "#{path.css}tools/"

# Default Task watching for changes in the css folder
gulp.task 'default', ->
	browserSync
		notify: false
		server: {baseUrl: './'}
	gulp.watch ['*.html'], browserSync.reload
	gulp.watch "#{path.img}icons/@2x/*.png", ['sprite']
	gulp.watch "#{path.scss}**/*.scss", ['sass']






