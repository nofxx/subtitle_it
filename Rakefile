require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "subtitle_it"
    gem.summary = "Download, edit and create subtitles."
    gem.description = "Download, edit and create subtitles. Supports various formats."
    gem.email = "x@nofxx.com"
    gem.homepage = "http://github.com/nofxx/subtitle_it"
    gem.authors = ["Marcos Piccinini"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

task :default => :build
