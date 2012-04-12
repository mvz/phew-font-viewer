require 'gir_ffi-pango'

GirFFI.setup :Gdk
Gdk.init []

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

Pango::Script.symbols.each do |script|
  lang = Pango.script_get_sample_language script
  unless lang.nil?
    puts "#{script}: #{lang.to_string}; #{lang.get_scripts.join ', '}, #{lang.get_sample_string}"
  else
    puts script
  end
end
