require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'date'
require 'reverse_markdown'

# usage: ruby import.rb feed.xml
# feed.xml is an file you can download from most websites that support RSS

data = File.read ARGV[0]
doc = Nokogiri::XML(data)

@posts = {}

def add(node)
  id = node.search('id').first.content
  type = node.search('category').first.attr('term').split('#').last
  if type=='post'
    @posts[id] = Post.new(node)
  else
    puts "there is a tag named" +type # You can delete lines 20-22 without affecting the generated files.
  end
end

def write(post)
  puts "writing #{post.file_name}"
  File.open(File.join('_posts', post.file_name), 'w') do |file|
    file.write post.header
    file.write "\n\n"
    file.write post.content
  end
end

class Post
  def initialize(node)
    @node = node
  end

  def title
    @node.search('title').first.content
  end

  def content_html
    @node.search('content').first.content
  end

  def content
    ReverseMarkdown.convert content_html
  end

  def creation_date
    creation_datetime.strftime("%Y-%m-%d")
  end

  def creation_datetime
    Date.parse(@node.search('published').first.content)
  end

  def param_name
    title.split(/[^a-zA-Z0-9]+/).join('-')
  end

  def file_name
    %{#{creation_date}-#{param_name}.markdown}
  end

  def header
    [
      '---',
      %{layout: post},
      %{title: #{title}},
      %{date: #{creation_datetime}},
      '---'
    ].join("\n")
  end
end

entries = {}

doc.search('entry').each do |entry|
  add entry
end

#FileUtils.rm_rf('_posts')
Dir.mkdir("_posts") unless File.directory?("_posts")

@posts.each do |id, post|
  write post
end
