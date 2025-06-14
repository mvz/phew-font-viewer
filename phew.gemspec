# frozen_string_literal: true

require_relative "lib/phew/version"

Gem::Specification.new do |spec|
  spec.name = "phew"
  spec.version = Phew::VERSION
  spec.authors = ["Matijs van Zuijlen"]
  spec.email = ["matijs@matijs.net"]

  spec.summary = "A GNOME Font Viewer"
  spec.description = "List and compare installed fonts on GNOME"
  spec.homepage = "http://www.github.com/mvz/phew-font-viewer"

  spec.license = "GPL-3"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = File.read("Manifest.txt").split
  spec.bindir = "bin"
  spec.executables = ["phew"]
  spec.require_paths << "lib"

  spec.rdoc_options = ["--main", "README.md"]

  spec.add_dependency "gir_ffi-gtk", "~> 0.18.0"
  spec.add_dependency "gir_ffi-pango", "0.0.18"

  spec.add_development_dependency "atspi_app_driver", "~> 0.10.1"
  spec.add_development_dependency "minitest", "~> 5.12"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rake-manifest", "~> 0.2.0"
  spec.add_development_dependency "rubocop", "~> 1.76"
  spec.add_development_dependency "rubocop-minitest", "~> 0.38.0"
  spec.add_development_dependency "rubocop-packaging", "~> 0.6.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.25"
end
