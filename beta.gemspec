# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "beta/version"

Gem::Specification.new do |s|
  s.name        = "beta"
  s.version     = Beta::VERSION
  s.authors     = ["Andrew Nordman"]
  s.email       = ["cadwallion@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Beta restriction gem}
  s.description = %q{Gem to handle multiple common cases of beta rollout}

  s.rubyforge_project = "beta"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
