require 'ffi-gtk3'
Gtk.init

GirFFI.setup :Pango
#GirFFI.setup :PangoCairo

module Pango
  load_class :Font
  load_class :Language

  class Font
    def get_coverage lang
      ptr = Lib.pango_font_get_coverage(self, lang)
      Pango::Coverage.wrap ptr
    end
  end

  class Language
    _setup_instance_method "get_scripts"

    def get_scripts_with_override
      ptr, num = self.get_scripts_without_override
      vals = GirFFI::ArgHelper.ptr_to_typed_array :gint32, ptr, num
      vals.map {|val| Pango::Script[val]}
    end

    alias get_scripts_without_override get_scripts
    alias get_scripts get_scripts_with_override
  end

  module Lib
    attach_function :pango_font_get_coverage, [:pointer, :pointer], :pointer
  end
end

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
