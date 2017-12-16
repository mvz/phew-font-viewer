Gem::Specification.new do |s|
  s.name = 'phew'
  s.version = '0.0.3'

  s.summary = 'A GNOME Font Viewer'
  s.description = 'List and compare installed fonts on GNOME'
  s.required_ruby_version = '>= 2.1.0'

  s.authors = ['Matijs van Zuijlen']
  s.email = ['matijs@matijs.net']
  s.homepage = 'http://www.github.com/mvz/phew-font-viewer'

  s.license = 'GPL-3'

  s.files = Dir['{bin,lib,test,doc}/**/*',
                '*.md',
                'Gemfile',
                'COPYING',
                'Rakefile'] & `git ls-files -z`.split("\0")

  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'phew'

  s.rdoc_options = ['--main', 'README.md']

  s.add_dependency('gir_ffi-gtk', ['~> 0.11.0'])
  s.add_dependency('gir_ffi-pango', ['0.0.9'])
  s.add_development_dependency('atspi_app_driver', ['0.2.0'])
  s.add_development_dependency('minitest', ['~> 5.5'])
  s.add_development_dependency('rake', ['~> 12.0'])
end
