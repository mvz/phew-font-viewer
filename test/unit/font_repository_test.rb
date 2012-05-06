require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

describe Phew::FontRepository do
  describe "#get_font" do
    it "returns an instance of Phew::Font" do
      repo = Phew::FontRepository.new
      font = repo.get_font "Sans"
      font.must_be_instance_of Phew::Font
    end

    it "returns the same object if called again with the same description" do
      repo = Phew::FontRepository.new
      font = repo.get_font "Sans"
      font_again = repo.get_font "Sans"
      font_again.must_be_same_as font
    end
  end
end
