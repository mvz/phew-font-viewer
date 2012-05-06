# Font family. Handles coverage, among other things.
module Phew
  class Font
    # Initialize the font from a text description. The text description should be
    # in the format accepted by Pange::FontDescription.from_string.
    #
    # @param [String] text_description Description of the font to use.
    def initialize text_description
      fd = Pango::FontDescription.from_string text_description
      ctx = Gdk.pango_context_get
      fontmap = ctx.get_font_map
      @font = fontmap.load_font ctx, fd
    end

    # Summarize coverage of the given text by the glyphs in the font.
    #
    # @return A hash with keys :none, :fallback, :approximate, :exact, and values
    #   indicating the number of characters in the text that have that coverage.
    def coverage_summary text
      lang = Pango::Language.new
      cov = @font.get_coverage lang
      text_cov = text.each_codepoint.map {|cp| cov.get cp}
      Hash[
        Pango::CoverageLevel.symbols.map {|lvl| [lvl, text_cov.count(lvl)]} ]
    end
  end
end
