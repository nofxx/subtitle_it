Gem::Specification.new do |s|
  s.name = %q{subtitle_it}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["FIXME full name"]
  s.cert_chain = ["/Users/nofxx/.gem/gem-public_cert.pem"]
  s.date = %q{2008-09-08}
  s.default_executable = %q{subtitle_it}
  s.description = %q{description of gem}
  s.email = ["FIXME email"]
  s.executables = ["subtitle_it"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "website/index.txt"]
  s.files = [".autotest", "History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.markdown", "README.txt", "Rakefile", "bin/subtitle_it", "config/hoe.rb", "config/requirements.rb", "lib/subtitle_it.rb", "lib/subtitle_it/delay.rb", "lib/subtitle_it/formats/pseudo.rb", "lib/subtitle_it/formats/srt.rb", "lib/subtitle_it/formats/sub.rb", "lib/subtitle_it/formats/yml.rb", "lib/subtitle_it/subline.rb", "lib/subtitle_it/subtime.rb", "lib/subtitle_it/subtitle.rb", "lib/subtitle_it/version.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "spec/fixtures/godfather.srt", "spec/fixtures/pulpfiction.sub", "spec/fixtures/sincity.yml", "spec/spec.opts", "spec/spec_helper.rb", "spec/subtitle_it/formats/pseudo_spec.rb", "spec/subtitle_it/formats/srt_spec.rb", "spec/subtitle_it/formats/sub_spec.rb", "spec/subtitle_it/formats/yml_spec.rb", "spec/subtitle_it/subline_spec.rb", "spec/subtitle_it/subtime_spec.rb", "spec/subtitle_it/subtitle_spec.rb", "spec/subtitle_it_spec.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/rspec.rake", "tasks/website.rake", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://subtitle_it.rubyforge.org}
  s.post_install_message = %q{
For more information on subtitle_it, see http://github.com/nofxx/subtitle_it

}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{subtitle_it}
  s.rubygems_version = %q{1.2.0}
  s.signing_key = %q{/Users/nofxx/.gem/gem-private_key.pem}
  s.summary = %q{description of gem}

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