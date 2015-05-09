Gem::Specification.new do |s|
  s.name = 'subtitle_it'
  s.version = '1.9.0'

  s.authors = ["Marcos Piccinini"]
  s.email = 'x@nofxx.com'

  s.date = Time.now.strftime("%Y-%m-%d")
  s.default_executable = 'subtitle_it'

  s.homepage = 'http://github.com/nofxx/subtitle_it'
  s.description = 'Download, edit and create subtitles. Supports various formats.'
  s.summary = 'Download, edit and create subtitles.'

  s.files = `git ls-files -z`.split("\x0")
  s.executables  = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.extra_rdoc_files = s.files.grep(%r{^(rdoc)/})
  s.require_paths = ['lib']

  s.add_dependency 'colorize'
  s.add_dependency 'nokogiri'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-mocks', '~> 3.0'
end
