# frozen_string_literal: true

require "gir_ffi-gtk3"

module Phew
  # Main Phew window
  class Window < Gtk::Window
    # Set up generic signal handlers for the window:
    # - Closing the window ends the application
    # - Pressing Ctrl-Q closes the window.
    def connect_signals
      signal_connect("destroy") { on_destroy_event }
      signal_connect("key-press-event") { |_, evt, _| on_key_press_event evt }
    end

    def on_destroy_event
      Gtk.main_quit
      false
    end

    def on_key_press_event(evt)
      destroy if evt.state[:control_mask] && evt.keyval == "q".ord
      false
    end
  end
end
