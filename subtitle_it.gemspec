Gem::Specification.new do |s|
  s.name = %q{subtitle_it}
  s.version = "0.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Piccinini", "Warlley Rezende"]
  s.date = %q{2008-09-08}
  s.default_executable = %q{subtitle_it}
  s.description = %q{description of gem}
  s.email = ["x@nofxx.com"]
  s.executables = ["subtitle_it"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "README.markdown"]
  s.files = [".autotest", "History.txt", "License.txt", "Manifest.txt", "README.markdown", "README.txt", "Rakefile", "bin/subtitle_it", "config/hoe.rb", "config/requirements.rb", "lib/subtitle_it.rb", "lib/subtitle_it/formats/ass.rb", "lib/subtitle_it/formats/rsb.rb", "lib/subtitle_it/formats/srt.rb", "lib/subtitle_it/formats/sub.rb", "lib/subtitle_it/formats/xml.rb", "lib/subtitle_it/formats/yml.rb", "lib/subtitle_it/movie.rb", "lib/subtitle_it/movie_hasher.rb", "lib/subtitle_it/subline.rb", "lib/subtitle_it/subtime.rb", "lib/subtitle_it/subtitle.rb", "lib/subtitle_it/version.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "spec/fixtures/godfather.srt", "spec/fixtures/huge.ass", "spec/fixtures/movie.xml", "spec/fixtures/movie.yml", "spec/fixtures/pseudo.rsb", "spec/fixtures/pulpfiction.sub", "spec/fixtures/sincity.yml", "spec/spec.opts", "spec/spec_helper.rb", "spec/subtitle_it/formats/ass_spec.rb", "spec/subtitle_it/formats/rsb_spec.rb", "spec/subtitle_it/formats/srt_spec.rb", "spec/subtitle_it/formats/sub_spec.rb", "spec/subtitle_it/formats/xml_spec.rb", "spec/subtitle_it/formats/yml_spec.rb", "spec/subtitle_it/subline_spec.rb", "spec/subtitle_it/subtime_spec.rb", "spec/subtitle_it/subtitle_spec.rb", "spec/subtitle_it_spec.rb", "subtitle_it.gemspec", "tasks/deployment.rake", "tasks/environment.rake", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nofxx/subtitle_it}
  s.post_install_message = %q{
For more information on subtitle_it, see http://github.com/nofxx/subtitle_it

}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{subtitle_it}
  s.rubygems_version = %q{1.2.0}

  s.summary = %q{Ruby tool to work with subtitle files}
  
  s.add_dependency(%q<hpricot>, [">= 0.6"])
  
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end