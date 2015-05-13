# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'phew'
  s.version = '0.0.1'

  s.summary = 'A GNOME Font Viewer'
  s.description = 'List and compare installed fonts on GNOME'
  s.required_ruby_version = '>= 1.9.3'

  s.authors = ['Matijs van Zuijlen']
  s.email = ['matijs@matijs.net']
  s.homepage = 'http://www.github.com/mvz/phew-font-viewer'

  s.license = 'GPL-3'

  s.files = Dir['{bin,lib,test,doc}/**/*',
                '*.md',
                'Gemfile',
                'COPYING',
                'Rakefile'] & `git ls-files -z`.split("\0")

  s.rdoc_options = ['--main', 'README.md']

  s.add_dependency('gir_ffi-gtk', ['~> 0.7.0'])
  s.add_dependency('gir_ffi-pango', ['~> 0.0.5'])
  s.add_development_dependency('rake', ['~> 10.1'])
  s.add_development_dependency('minitest', ['~> 5.5'])
end
