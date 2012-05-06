module Phew
  class FontRepository
    def initialize
      @store = {}
    end
    # Retrieve a font based on the given text description. The text description
    # should be in the format accepted by Font#new.
    #
    # @param [String] text_description Description of the font to retrieve.
    def get_font text_description
      @store[text_description] ||= Font.new text_description
    end
  end
end
