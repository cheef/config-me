# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "config-me/version"

Gem::Specification.new do |s|
  s.name        = "config-me"
  s.version     = ConfigMe::VERSION
  s.authors     = ["Ivan Garmatenko"]
  s.email       = %w(cheef.che@gmail.com)
  s.homepage    = "http://github.com/cheef/config-me"
  s.summary     = %q{Provides convenient tool for storing configuration}
  s.description = %q{Provides convenient tool for storing configuration}

  s.rubyforge_project = "config-me"

  s.files = []
  %w(lib).each do |folder|
    s.files += Dir.glob("#{folder}/**/*.*")
  end

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w(lib)

  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
end