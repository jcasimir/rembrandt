require './test/test_helper'
require './lib/rembrandt/engines/web_service'

class EnginesPygmentizeTest < CodeHighlightTest
  def test_it_exists
    assert Rembrandt::Engines::WebService.new
  end

  attr_reader :highlighter

  def setup
    @highlighter = Rembrandt::Engines::WebService.new
  end

  def test_it_highlights
    VCR.use_cassette('web_engine_highlights_ruby_sample_1') do
      assert_highlight 'ruby_sample_1.rb', 'ruby'
    end
  end
end