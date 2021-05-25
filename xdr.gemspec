# frozen_string_literals: true
require_relative "lib/xdr/version"

Gem::Specification.new do |spec|
  spec.name = "xdr"
  spec.version = XDR::VERSION
  spec.authors = ["Scott Fleckenstein"]
  spec.email = ["scott@stellar.org"]
  spec.summary = "XDR Helper Library"
  spec.homepage = "https://github.com/astroband/ruby-xdr"
  spec.license = "Apache-2.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files += Dir["README*", "LICENSE*", "CHANGELOG*"]
  spec.bindir = "exe"

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/xdr/#{spec.version}/",
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}"
  }

  spec.required_ruby_version = ">= 2.4.0"

  spec.add_dependency "activesupport", ">= 4.2", "< 7.0"
  spec.add_dependency "activemodel", ">= 4.2", "< 7.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.19"
end
