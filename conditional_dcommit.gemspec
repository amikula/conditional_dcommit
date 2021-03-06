# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{conditional_dcommit}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alf Mikula"]
  s.date = %q{2009-10-20}
  s.default_executable = %q{conditional_dcommit}
  s.email = %q{amikula@gmail.com}
  s.executables = ["conditional_dcommit"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "bin/conditional_dcommit",
     "conditional_dcommit.gemspec",
     "data/growlNotify.applescript",
     "data/growlNotify.applescript",
     "data/stop_sign.jpg",
     "data/stop_sign.jpg",
     "data/traffic_green.jpg",
     "data/traffic_green.jpg",
     "lib/conditional_dcommit.rb",
     "lib/conditional_dcommit/command.rb",
     "lib/conditional_dcommit/package.rb",
     "spec/conditional_dcommit/command_spec.rb",
     "spec/conditional_dcommit/package_spec.rb",
     "spec/conditional_dcommit_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/amikula/conditional_dcommit}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Loops through rebase and test until tests pass and there are no new changes in the repository, then issues a git svn dcommit.}
  s.test_files = [
    "spec/conditional_dcommit/command_spec.rb",
     "spec/conditional_dcommit/package_spec.rb",
     "spec/conditional_dcommit_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<open4>, [">= 0"])
    else
      s.add_dependency(%q<open4>, [">= 0"])
    end
  else
    s.add_dependency(%q<open4>, [">= 0"])
  end
end
