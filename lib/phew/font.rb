module Phew
  # Font family. Handles coverage, among other things.
  class Font
    # Initialize the font from a text description. The text description should be
    # in the format accepted by Pango::FontDescription.from_string.
    #
    # @param [Pango::Context] context Pango context to retrieve font from.
    # @param [String] text_description Description of the font to create.
    def initialize context, text_description
      fd = Pango::FontDescription.from_string text_description
      fontmap = context.get_font_map
      @font = fontmap.load_font context, fd
    end

    # Summarize coverage of the given text by the glyphs in the font.
    #
    # @return A hash with keys :none, :fallback, :approximate, :exact, and values
    #   indicating the number of characters in the text that have that coverage.
    def coverage_summary text
      lang = Pango::Language.new
      cov = @font.get_coverage lang
      text_cov = text.each_codepoint.map { |cp| cov.get cp }
      Hash[
        Pango::CoverageLevel::Enum.symbols.map { |lvl| [lvl, text_cov.count(lvl)] }]
    end
  end
end
