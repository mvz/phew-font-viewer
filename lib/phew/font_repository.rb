# frozen_string_literal: true

require "phew/font"

module Phew
  # Cache for font information retrieved from a Pango context
  class FontRepository
    # @param [Pango::Context] context Pango context to retrieve fonts from.
    def initialize(context)
      @store = {}
      @context = context
    end

    # Retrieve a font based on the given text description. The text description
    # should be in the format accepted by Font#new.
    #
    # @param [String] text_description Description of the font to retrieve.
    def get_font(text_description)
      @store[text_description] ||= Font.new @context, text_description
    end
  end
end
