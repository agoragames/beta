# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "beta/version"

Gem::Specification.new do |s|
  s.name        = "beta"
  s.version     = Beta::VERSION
  s.authors     = ["Andrew Nordman", "Logan Koester", "Matt Wilson", "David Czarnecki"]
  s.email       = ["cadwallion@gmail.com", "lkoester@majorleaguegaming.com", "mwilson@majorleaguegaming.com", "dczarnecki@majorleaguegaming.com"]
  s.homepage    = "https://github.com/agoragames/beta"
  s.summary     = %q{Beta restriction gem}
  s.description = %q{Gem to handle multiple common cases of beta rollout}

  s.rubyforge_project = "beta"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rails", "~>3.1.0"

  s.add_dependency "redis"
end
