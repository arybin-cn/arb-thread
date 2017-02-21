# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arb/thread/version'

Gem::Specification.new do |spec|
  spec.name          = "arb-thread"
  spec.version       = Arb::Thread::VERSION
  spec.authors       = ["arybin"]
  spec.email         = ["arybin@163.com"]

  spec.summary       = %q{A simple "thread pool" for parallel tasks.}
  spec.description   = %q{A simple "thread pool" for parallel tasks.}
  spec.homepage      = "https://github.com/arybin-cn/arb-thread"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
