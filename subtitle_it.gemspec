$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'subtitle_it/version'

Gem::Specification.new do |s|
  s.name = 'subtitle_it'
  s.version     = SubtitleIt::VERSION
  s.platform    = Gem::Platform::RUBY

  s.authors = ["Marcos Piccinini"]
  s.email = 'x@nofxx.com'

  s.date = Time.now.strftime("%Y-%m-%d")
  s.default_executable = 'subtitle_it'

  s.homepage    = 'http://github.com/nofxx/subtitle_it'
  s.description = 'Download, edit and create subtitles. Supports various formats.'
  s.summary     = 'Download, edit and create subtitles.'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.executables  = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # s.extra_rdoc_files = s.files.grep(%r{^(rdoc)/})

  s.add_dependency 'colorize'
  s.add_dependency 'nokogiri'
  s.add_dependency 'charlock_holmes'
end
