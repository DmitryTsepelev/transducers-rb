require_relative "lib/transducers/version"

Gem::Specification.new do |spec|
  spec.name = "transducers"
  spec.version = Transducers::VERSION
  spec.authors = ["DmitryTsepelev"]
  spec.email = ["dmitry.a.tsepelev@gmail.com"]
  spec.homepage = "https://github.com/DmitryTsepelev/transducers-rb"
  spec.summary = "An experimental transducers implementation for Ruby"

  spec.license = "MIT"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/DmitryTsepelev/transducers-rb/issues",
    "changelog_uri" => "https://github.com/DmitryTsepelev/transducers-rb/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/DmitryTsepelev/transducers-rb/blob/master/README.md",
    "homepage_uri" => "https://github.com/DmitryTsepelev/transducers-rb",
    "source_code_uri" => "https://github.com/DmitryTsepelev/transducers-rb"
  }

  spec.files = [
    Dir.glob("lib/**/*"),
    "README.md",
    "CHANGELOG.md",
    "LICENSE.txt"
  ].flatten

  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.1.0"

  spec.add_development_dependency "memory_profiler"
end
