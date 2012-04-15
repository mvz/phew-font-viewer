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

  def boot timeout=3
    raise "Already booted" if @pid
    @pid = Process.spawn "ruby #@app_file"

    @killed = false

    Thread.new do
      sleep timeout
      @killed = true if pid
      Process.kill "TERM", @pid if @pid
      sleep 1 if @pid
      Process.kill "KILL", @pid if @pid
    end
  end

  def cleanup expected_status = 0
    return unless @pid
    _, status = Process.wait2 @pid
    @pid = nil
    @killed.must_equal false
    status.exitstatus.must_equal 0
  end
end

describe "The Phew application" do
  before do
    @driver = PhewDriver.new
    @driver.boot
  end

  it "starts and can be quit with Ctrl-q" do
    acc = try_repeatedly { find_app "phew" }
    acc.wont_be_nil

    frame = acc.get_child_at_index 0
    frame.role.must_equal :frame
    frame.grab_focus
    sleep 0.01

    press_ctrl_q
  end

  after do
    @driver.cleanup
  end
end
