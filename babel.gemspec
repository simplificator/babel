# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{babel}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["simplificator"]
  s.date = %q{2009-07-13}
  s.email = %q{info@simplificator.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION.yml",
     "babel.gemspec",
     "lib/babel.rb",
     "lib/babel/babel.rb",
     "lib/babel/profile.rb",
     "lib/babel/string_extensions.rb",
     "lib/profiles/profile_deu.yml",
     "lib/profiles/profile_eng.yml",
     "lib/profiles/profile_fra.yml",
     "lib/profiles/profile_ita.yml",
     "lib/profiles/profile_spa.yml",
     "lib/profiles/udhr_txt.zip",
     "test/babel_test.rb",
     "test/profile_test.rb",
     "test/string_extensions_test.rb",
     "test/test_helper.rb",
     "test/train.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/simplificator/babel}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Utility to guess the language of a text}
  s.test_files = [
    "test/babel_test.rb",
     "test/profile_test.rb",
     "test/string_extensions_test.rb",
     "test/test_helper.rb",
     "test/train.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ya2yaml>, [">= 0.2.6"])
    else
      s.add_dependency(%q<ya2yaml>, [">= 0.2.6"])
    end
  else
    s.add_dependency(%q<ya2yaml>, [">= 0.2.6"])
  end
end
