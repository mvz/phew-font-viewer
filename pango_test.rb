require 'ffi-gtk3'
require 'gir_ffi-pango'

Gtk.init

ctx = Gdk.pango_context_get
fontmap = ctx.get_font_map

lang = Pango::Language.from_string "ja"
sample = lang.get_sample_string
puts "Language: #{lang.to_string}"
puts "Scripts: #{lang.get_scripts.join ', '}"
puts "Sample: #{sample}"

fd = Pango::FontDescription.new
fd.set_family "TakaoMincho"

fnt = fontmap.load_font ctx, fd
puts "Font: #{fnt.describe.to_string}"
cov = fnt.get_coverage lang

sample_cov = lang.get_sample_string.each_codepoint.map {|cp| cov.get cp}
mostly = [:none, :fallback, :coverage, :exact].max_by {|i| sample_cov.count(i)}
puts "Coverage mostly: #{mostly}"

fams = fontmap.list_families
p fams.map &:name
