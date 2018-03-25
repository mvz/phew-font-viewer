# frozen_string_literal: true

module Phew
  # A script.
  class Script
    def initialize(name)
      symbol = name.to_sym
      @symbol = symbol
      @lang = Pango.script_get_sample_language symbol
    end

    def sample_string
      if @lang.nil?
        'No sample available'
      else
        @lang.get_sample_string
      end
    end
  end
end
