# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "phew"
  spec.version = "0.0.5"

  spec.summary = "A GNOME Font Viewer"
  spec.description = "List and compare installed fonts on GNOME"
  spec.required_ruby_version = ">= 2.6.0"

  spec.authors = ["Matijs van Zuijlen"]
  spec.email = ["matijs@matijs.net"]
  spec.homepage = "http://www.github.com/mvz/phew-font-viewer"

  spec.license = "GPL-3"

  spec.files = File.read("Manifest.txt").split

  spec.require_paths << "lib"
  spec.bindir = "bin"
  spec.executables << "phew"

  spec.rdoc_options = ["--main", "README.md"]

  spec.add_dependency("gir_ffi-gtk", ["~> 0.15.0"])
  spec.add_dependency("gir_ffi-pango", ["0.0.14"])
  spec.add_development_dependency("atspi_app_driver", "~> 0.7.0")
  spec.add_development_dependency("minitest", ["~> 5.12"])
  spec.add_development_dependency("pry", "~> 0.14.0")
  spec.add_development_dependency("rake", ["~> 13.0"])
  spec.add_development_dependency("rake-manifest", "~> 0.2.0")
  spec.add_development_dependency("rubocop", "~> 1.22.0")
  spec.add_development_dependency("rubocop-minitest", "~> 0.16.0")
  spec.add_development_dependency("rubocop-performance", "~> 1.12.0")
end
