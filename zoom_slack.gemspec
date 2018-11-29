# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "zoom_slack"
  s.version     = "0.0.1"
  s.date        = "2018-11-29"
  s.summary     = "Zoom to Slack integration"
  s.description = "Automatically update your Slack status when you're in a Zoom meeting."
  s.authors     = ["Burke Webster"]
  s.email       = "burke.webster@gmail.com"
  s.homepage    = "https://github.com/bwebster/zoom_slack"
  s.license     = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "bin"
  s.executables   << "zoom_slack"
  s.require_paths = ["lib"]

  s.add_dependency "faraday"
  s.add_dependency "immutable-struct"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
end
