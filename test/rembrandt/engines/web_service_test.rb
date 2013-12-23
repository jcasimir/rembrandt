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

  def test_it_is_available_when_the_website_responds
    VCR.use_cassette('web_engine_is_accessible') do
      assert Rembrandt::Engines::WebService.available?
    end
  end

  def test_it_is_not_available_when_the_website_does_not_respond
    # VCR.use_cassette('web_engine_is_accessible') do
    #   assert Rembrandt::Engines::WebService.available?
    # end
  end
end
