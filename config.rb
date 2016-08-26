###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :life do
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates

require 'active_support/core_ext'

helpers do
  def blog_title
    'DevOps медитация'
  end

  def blog_subtitle
    'Через медитацию к полноценной DevOps жизни'
  end

  def tag_url tag
    link_to tag, "/blog/categories/#{tag}"
  end

  def site_url(protocol = 'http')
    if development?
      "#{protocol}://localhost:4567"
    else
      "#{protocol}://evtuhovich.ru"
    end
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :haml, :ugly => true

Time.zone = "Moscow"

activate :blog do |blog|
  blog.name = "blog"
  blog.prefix = ""
  blog.sources = '{year}/{year}-{month}-{day}-{title}.html'
  blog.permalink = ":year/:month/:day/:title/index.html"
  # blog.sources = ":year-:month-:day-:title.html"
  blog.taglink = "categories/:tag/index.html"
  blog.layout = 'layouts/blog-post'
  blog.summary_separator = /(<!-- more -->)/
  blog.summary_length = nil
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "blog/tag.html"
#  blog.calendar_template = "blog/calendar.html"

  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "/page/:num"
  # blog.publish_future_dated = true
  # blog.custom_collections = {
  #   categories: {
  #     link: '/categories/{categories}/',
  #     template: '/category.html'
  #   }
  # }
end

activate :syntax

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true
# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'devops-meditation.ru'
  s3_sync.region                     = 'eu-central-1'
  s3_sync.delete                     = false # We delete stray files by default.
end
