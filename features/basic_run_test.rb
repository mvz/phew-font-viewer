# frozen_string_literal: true

require_relative 'test_helper'
require 'atspi_app_driver'

# Test driver for the Phew application.
class PhewDriver < AtspiAppDriver
  def initialize
    verbose = ENV['VERBOSE'] == 'true'
    super 'phew', verbose: verbose
  end
end

describe 'The Phew application' do
  before do
    @driver = PhewDriver.new
    @driver.boot
  end

  it 'starts and can be quit with Ctrl-q' do
    sleep 0.05
    @driver.press_ctrl_q

    status = @driver.cleanup
    status.exitstatus.must_equal 0
  end

  it 'shows a dropdown list of scripts' do
    frame = @driver.frame

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

    @driver.press_ctrl_q
    status = @driver.cleanup
    status.exitstatus.must_equal 0
  end

  after do
    @driver.cleanup
  end
end
