require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

require 'gir_ffi'

GirFFI.setup :Atspi
Atspi.load_class :Accessible

module Atspi
  # Utility monkey-patches for the Atspi::Accessible class
  class Accessible
    def each_child
      child_count.times do |i|
        yield get_child_at_index i
      end
    end

    def find_role role, regex = //
      return self if role == self.role && name =~ regex
      each_child do |child|
        result = child.find_role role, regex
        return result if result
      end
      nil
    end

    def inspect_recursive level = 0, maxlevel = 4
      each_child do |child|
        puts "#{'  ' * level} > name: #{child.name}; role: #{child.role}"
        child.inspect_recursive(level + 1) unless level >= maxlevel
      end
    end
  end
end

def find_app name
  desktop = Atspi.get_desktop(0)
  desktop.each_child do |child|
    next if child.nil?
    return child if child.name == name
  end
  nil
end

def try_repeatedly
  100.times.each do |num|
    result = yield
    return result if result
    sleep_time = 0.01 * (num + 1)
    sleep sleep_time
  end
  yield
end

def press_ctrl_q
  Atspi.generate_keyboard_event(37, nil, :press)
  Atspi.generate_keyboard_event(24, nil, :pressrelease)
  Atspi.generate_keyboard_event(37, nil, :release)
end

# Test driver for the Phew application. Takes care of boot and shutdown, and
# provides a handle on the GUI's main UI frame.
class PhewDriver
  def initialize
    @app_file = File.expand_path('../../bin/phew', File.dirname(__FILE__))
    @lib_dir = File.expand_path('../../lib', File.dirname(__FILE__))
    @pid = nil
    @killed = false
  end

  def boot timeout = 10
    raise 'Already booted' if @pid
    @pid = Process.spawn "ruby -I#{@lib_dir} #{@app_file}"

    @killed = false
    @cleanup = false

    Thread.new do
      ((timeout - 1) * 10).times do
        break if @cleanup
        sleep 0.1
      end

      10.times do
        break unless @pid
        sleep 0.1
      end

      if @pid
        warn "About to kill child process #{@pid}"
        @killed = true
        Process.kill 'KILL', @pid
      end
    end
  end

  def cleanup
    return unless @pid
    @cleanup = true
    _, status = Process.wait2 @pid
    @pid = nil
    status
  end

  def find_and_focus_frame
    acc = try_repeatedly { find_app 'phew' }
    acc.wont_be_nil

    frame = acc.get_child_at_index 0
    frame.role.must_equal :frame
    frame.grab_focus
    sleep 0.1

    frame
  end
end

describe 'The Phew application' do
  before do
    @driver = PhewDriver.new
    @driver.boot
  end

  it 'starts and can be quit with Ctrl-q' do
    @driver.find_and_focus_frame

    press_ctrl_q

    status = @driver.cleanup
    status.exitstatus.must_equal 0
  end

  it 'shows a dropdown list of scripts' do
    frame = @driver.find_and_focus_frame

    box = frame.find_role :combo_box

    latin = box.find_role :menu_item, /latin/
    latin.wont_be_nil

    textbox = frame.find_role :text
    textbox.wont_be_nil
    textbox.get_text(0, 100).must_equal ''

    box.get_action_name(0).must_equal 'press'
    box.do_action 0
    latin.get_action_name(0).must_equal 'click'
    latin.do_action 0

    textbox.get_text(0, 100).must_equal 'The quick brown fox jumps over the lazy dog.'

    press_ctrl_q
    status = @driver.cleanup
    status.exitstatus.must_equal 0
  end

  after do
    @driver.cleanup
  end
end
