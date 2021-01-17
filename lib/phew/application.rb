# frozen_string_literal: true

require "gir_ffi-gtk3"

require "phew/font_repository"
require "phew/script"
require "phew/script_list"

module Phew
  # Main Phew application.
  class Application
    def initialize(gtk_application)
      @gtk_application = gtk_application
      @context = Gdk.pango_context_get
      @font_repository = FontRepository.new @context
      connect_signals
    end

    def present
      win.show_all
      win.children.first.visible = false if win.show_menubar
      win.present
    end

    private

    def combo
      @combo ||= ScriptList.new.tap(&:fill)
    end

    def textview
      @textview ||= Gtk::TextView.new
    end

    def build_vbox
      vbox = Gtk::VBox.new false, 0

      vbox.pack_start combo, false, false, 0
      vbox.pack_start textview, false, false, 0
      vbox.pack_start script_list_scroller, true, true, 0
      vbox
    end

    def vbox
      @vbox ||= build_vbox
    end

    def script_list_scroller
      @script_list_scroller ||= Gtk::ScrolledWindow.new(nil, nil).tap do |scr|
        lst = script_list
        scr.add lst
        lst.hadjustment = scr.hadjustment
        lst.vadjustment = scr.vadjustment
      end
    end

    def script_list
      @script_list ||= Gtk::TreeView.new_with_model(scriptmodel).tap do |view|
        renderer = Gtk::CellRendererText.new
        col = Gtk::TreeViewColumn.new
        col.set_title "Font Name"
        col.pack_start renderer, true
        col.add_attribute renderer, "text", 0
        view.append_column col
      end
    end

    def scriptmodel
      @scriptmodel ||= Gtk::ListStore.new [GObject::TYPE_STRING]
    end

    def build_win
      win = Gtk::ApplicationWindow.new @gtk_application
      win.add vbox
      win
    end

    def win
      @win ||= build_win
    end

    # Set up all signal handlers
    def connect_signals
      combo.signal_connect("changed") { on_combo_changed_signal }
    end

    def on_combo_changed_signal
      script = Script.new combo.active_text.to_sym
      # FIXME: Add override for Gtk::TextBuffer.set_text so #text= works properly
      textview.buffer.set_text script.sample_string, -1
      fill_font_list script
    end

    def fill_font_list(script)
      scriptmodel.clear

      font_families.each do |fam|
        font = @font_repository.get_font fam.name

        if sample_coverage(font, script) == :exact
          row = scriptmodel.append
          scriptmodel.set_value row, 0, fam.name
        end
      end
    end

    def sample_coverage(font, script)
      sample_cov = font.coverage_summary script.sample_string
      [:none, :fallback, :approximate, :exact].max_by { |i| sample_cov[i] }
    end

    def font_families
      fontmap = @context.get_font_map

      fontmap.list_families
    end
  end
end
