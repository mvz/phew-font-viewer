# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "phew"
  s.version = "0.0.5"

  s.summary = "A GNOME Font Viewer"
  s.description = "List and compare installed fonts on GNOME"
  s.required_ruby_version = ">= 2.5.0"

  s.authors = ["Matijs van Zuijlen"]
  s.email = ["matijs@matijs.net"]
  s.homepage = "http://www.github.com/mvz/phew-font-viewer"

  s.license = "GPL-3"

  s.files = Dir["{bin,lib,test,doc}/**/*",
                "*.md",
                "Gemfile",
                "COPYING",
                "Rakefile"] & `git ls-files -z`.split("\0")

  s.require_paths << "lib"
  s.bindir = "bin"
  s.executables << "phew"

  s.rdoc_options = ["--main", "README.md"]

  s.add_dependency("gir_ffi-gtk", ["~> 0.15.0"])
  s.add_dependency("gir_ffi-pango", ["0.0.14"])
  s.add_development_dependency("atspi_app_driver", "~> 0.7.0")
  s.add_development_dependency("minitest", ["~> 5.12"])
  s.add_development_dependency("pry", "~> 0.14.0")
  s.add_development_dependency("rake", ["~> 13.0"])
  s.add_development_dependency("rubocop", "~> 1.16.0")
  s.add_development_dependency("rubocop-minitest", "~> 0.12.1")
  s.add_development_dependency("rubocop-performance", "~> 1.11.0")
end
