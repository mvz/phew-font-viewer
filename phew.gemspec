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

  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = File.read("Manifest.txt").split
  spec.bindir = "bin"
  spec.executables = ["phew"]
  spec.require_paths << "lib"

  spec.rdoc_options = ["--main", "README.md"]

  spec.add_dependency "gir_ffi-gtk", "~> 0.17.0"
  spec.add_dependency "gir_ffi-pango", "0.0.17"

  spec.add_development_dependency "atspi_app_driver", "~> 0.9.0"
  spec.add_development_dependency "minitest", "~> 5.12"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rake-manifest", "~> 0.2.0"
  spec.add_development_dependency "rubocop", "~> 1.52"
  spec.add_development_dependency "rubocop-minitest", "~> 0.36.0"
  spec.add_development_dependency "rubocop-packaging", "~> 0.5.2"
  spec.add_development_dependency "rubocop-performance", "~> 1.18"
end
