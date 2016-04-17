# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qa_me_please/version'

Gem::Specification.new do |spec|
  spec.name          = "qa_me_please"
  spec.version       = QaMePlease::VERSION
  spec.authors       = ["Boris Kuznetsov"]
  spec.email         = ["achempion@gmail.com"]

  spec.summary       = %q{This tool created to automate process of shipping PRs to QA team.}
  spec.homepage      = "https://github.com/achempion/qa_me_please"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
