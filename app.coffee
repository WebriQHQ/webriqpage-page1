axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
records      = require 'roots-records'
collections  = require 'roots-collections'
excerpt      = require 'html-excerpt'
roots_rss_generator = require 'webriq-roots-rss-generator'
moment       = require 'moment'
SitemapGenerator = require 'sitemap-generator'

monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]

module.exports =
	ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

	locals:
		postExcerpt: (html, length, ellipsis) ->
			excerpt.text(html, length || 100, ellipsis || '...')
		dateFormat: (date, format) ->
			moment(date).format('ll')


	extensions: [
		records(
			characters: { file: "data/characters.json" }
			site: { file: "data/site.json" }
			slider: { file: "data/slider.json" }
			news: { file: "data/news.json" }
			client: { file: "data/client.json" }
			partners: { file: "data/partners.json" }
			footer: { file: "data/footer.json" }
			sidebar: { file: "data/sidebar.json" }
			),
		roots_rss_generator(
			folder: "posts"
			output: "feed.xml"
			maxcount: 5
			settings:
				title: "New title"
				feed_url: "http://page1.netlify.com/feed.xml"
				site_url: "http://page1.netlify.com"
				description: "This is new description"
			),
		collections(folder: 'services', layout: 'post'),
		collections(folder: 'featuredwork', layout: 'post'),
		collections(folder: 'posts', layout: 'post'),
		collections(folder: 'news', layout: 'post'),
		js_pipeline(files: 'assets/js/*.coffee'),
		css_pipeline(files: 'assets/css/*.styl')
	]


	stylus:
		use: [axis(), rupture(), autoprefixer()]
		sourcemap: true

	'coffee-script':
		sourcemap: true

	jade:
		pretty: true