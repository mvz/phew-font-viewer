require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

require 'gir_ffi'

GirFFI.setup :Atspi

def find_app name
  desktop = Atspi.get_desktop(0)
  cnt = desktop.child_count

  # We expect the app to be the last one.
  (0..cnt-1).reverse_each do |i|
    child = desktop.get_child_at_index i
    return child if child.name == name
  end
  return nil
end

def each_child acc
  cnt = acc.child_count

  (0..cnt-1).reverse_each do |i|
    child = acc.get_child_at_index i
    yield child
  end
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

def running_command command, timeout = 10
  pid = Process.spawn command

  killed = false

  Thread.new do
    sleep timeout
    killed = true if pid
    Process.kill "TERM", pid if pid
    sleep 1 if pid
    Process.kill "KILL", pid if pid
  end

  begin
    yield pid
    _, status = Process.wait2 pid
    pid = nil
    raise "Process under test was killed" if killed
    return status
  ensure
    Process.wait if pid
  end
end

describe "The Phew application" do
  before do
    @app_file = File.expand_path('../../bin/phew', File.dirname(__FILE__))
  end

  it "starts and can be quit with Ctrl-q" do
    status = running_command "ruby #@app_file" do
      acc = try_repeatedly { find_app "phew" }
      acc.wont_be_nil

      frame = acc.get_child_at_index 0
      frame.role.must_equal :frame

      frame.grab_focus
      sleep 0.01
      Atspi.generate_keyboard_event(37, nil, :press)
      Atspi.generate_keyboard_event(24, nil, :pressrelease)
      Atspi.generate_keyboard_event(37, nil, :release)
    end
    status.exitstatus.must_equal 0
  end
end
