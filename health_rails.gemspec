# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "health_rails/version"

Gem::Specification.new do |s|
  s.name        = "health_rails"
  s.version     = HealthRails::VERSION
  s.authors     = ["Daniel Spangenberg"]
  s.email       = ["daniel.spangenberg@parcydo.com"]
  s.homepage    = "http://parcydo.com"
  s.summary     = %q{Health rails provides your rails app a simple password protected health status page for other web services.}
  s.description = %q{Health rails gives you some default checks and a DSL for defining your own checks.}

  s.add_development_dependency "rails"
  s.add_development_dependency "rspec"

  s.rubyforge_project = "health_rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
