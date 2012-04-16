require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

require 'gir_ffi'

GirFFI.setup :Atspi

def each_child acc
  acc.child_count.times do |i|
    yield acc.get_child_at_index i
  end
end

def find_app name
  desktop = Atspi.get_desktop(0)
  each_child(desktop) {|child| return child if child.name == name }
  nil
end

def find_role acc, role
  return acc if role == acc.role
  each_child acc do |child|
    result = find_role child, role
    return result if result
  end
  nil
end

def try_repeatedly
  10.times.each do |num|
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

class PhewDriver
  def initialize
    @app_file = File.expand_path('../../bin/phew', File.dirname(__FILE__))
    @pid = nil
    @killed = false
  end

  def boot timeout=10
    raise "Already booted" if @pid
    @pid = Process.spawn "ruby #@app_file"

    @killed = false
    @cleanup = false

    Thread.new do
      (timeout * 10).times do
        break if @cleanup
        sleep 0.1
      end

      if @pid
        warn "About to kill child process #@pid"
        @killed = true
        Process.kill "KILL", @pid
      end
    end
  end

  def cleanup
    return unless @pid
    @cleanup = true
    _, status = Process.wait2 @pid
    @pid = nil
    return status
  end

  def get_and_focus_frame
    acc = try_repeatedly { find_app "phew" }
    acc.wont_be_nil

    frame = acc.get_child_at_index 0
    frame.role.must_equal :frame
    frame.grab_focus
    sleep 0.01

    return frame
  end

end

describe "The Phew application" do
  before do
    @driver = PhewDriver.new
    @driver.boot
  end

  it "starts and can be quit with Ctrl-q" do
    @driver.get_and_focus_frame

    press_ctrl_q
    sleep 0.1

    status = @driver.cleanup
    status.exitstatus.must_equal 0
  end

  it "shows a dropdown list of scripts" do
    frame = @driver.get_and_focus_frame

    box = find_role frame, :combo_box

    names = []
    each_child box do |child|
      each_child child do |gc|
        names << gc.name
      end
    end
    names.must_include "latin"

    press_ctrl_q
  end

  after do
    @driver.cleanup
  end
end
