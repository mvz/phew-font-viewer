require 'ffi-gtk3'
require 'gir_ffi-pango'

Gtk.init

if false
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
end

win = Gtk::Window.new :toplevel
win.signal_connect 'destroy' do
  Gtk.main_quit
  true
end

win.signal_connect 'key-press-event' do |wdg, evt, ud|
  if evt.state == :control_mask
    if evt.keyval == "q".ord
      win.destroy
    end
  end
  false
end

vbox = Gtk::VBox.new false, 0
win.add vbox

combo = Gtk::ComboBoxText.new
vbox.pack_start combo, false, false, 0

Pango::Script.symbols.each do |script|
  next if script == :invalid_code
  str = script.to_s
  txt = str.gsub(/_/, ' ')
  combo.append str, txt
end

combo.signal_connect 'changed' do
  script = combo.active_text.gsub(/ /, '_').to_sym
  lang = Pango.script_get_sample_language script

  msg = "Changed to #{script.inspect}"
  unless lang.nil?
    msg << "; #{lang.to_string}; #{lang.get_scripts.join ', '}, #{lang.get_sample_string}"
  end
  puts msg
end

win.show_all
Gtk.main
