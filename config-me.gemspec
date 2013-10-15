# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'config-me'
  s.version     = '0.0.8'
  s.authors     = ["Ivan Garmatenko"]
  s.email       = %w(cheef.che@gmail.com)
  s.homepage    = 'http://github.com/cheef/config-me'
  s.summary     = %q{Provides convenient tool for storing configuration}
  s.description = %q{Provides convenient tool for storing configuration}

  s.files += Dir.glob('lib/**/*.*')

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w(lib)

  s.add_runtime_dependency 'activesupport', '>= 3'

  s.add_development_dependency 'cucumber', '>= 1.3.8'
  s.add_development_dependency 'rspec', '>= 2.14'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'bundler'
end