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

def try_repeatedly
  10.times.each do |num|
    result = yield
    return result if result
    sleep_time = 0.05 + 0.05 * (num)**1.5
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

  it "starts and then stops" do
    status = running_command "ruby #@app_file" do
      # nothing to do
    end

    status.exitstatus.must_equal 0
  end

  it "starts and then can be accessed with Atspi" do
    running_command "ruby #@app_file" do
      acc = try_repeatedly { find_app "phew" }
      acc.wont_be_nil
    end
  end
end
