# frozen_string_literal: true

require "gir_ffi-gtk3"
require "gir_ffi-pango"

module Phew
  # Drop-down list of available scripts.
  class ScriptList < Gtk::ComboBoxText
    # FIXME: Should be able to fill inside #initialize
    def fill
      Pango::Script::Enum.symbols
        .map(&:to_s)
        .each { |str| append str, str }
    end
  end
end
