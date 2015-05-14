require_relative '../test_helper'

describe Phew::Font do
  describe '#coverage_summary' do
    it 'returns summarized coverage information for the given string' do
      ctx = Gdk.pango_context_get

      pfont = Phew::Font.new ctx, 'Sans'

      test_string = 'This is a test'
      sum = pfont.coverage_summary test_string

      sum.keys.sort.must_equal [:none, :fallback, :approximate, :exact].sort
      sum.values.inject(:+).must_equal test_string.size
    end
  end
end
