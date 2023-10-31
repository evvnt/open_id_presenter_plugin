lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "open_id_presenter_plugin/version"

Gem::Specification.new do |spec|
  spec.name          = "open_id_presenter_plugin"
  spec.version       = OpenIdPresenterPlugin::VERSION
  spec.authors       = ["Rhet Prieto"]
  spec.email         = ["dev@evvnt.com"]

  spec.summary       = %q{A COPRL presenter plugin for google maps images}
  spec.homepage      = 'http://github.com/evvnt/open_id_presenter_plugin'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake"
end
