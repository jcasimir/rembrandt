require './test/test_helper'
require './lib/rembrandt/engines/pygmentize'

class EnginesPygmentizeTest < CodeHighlightTest
  def test_it_exists
    assert Rembrandt::Engines::Pygmentize.new
  end

  attr_reader :highlighter

  def setup
    @highlighter = Rembrandt::Engines::Pygmentize.new
  end

  def test_it_highlights
    assert_highlight 'ruby_sample_1.rb', 'ruby'
  end

  def test_it_is_available_when_present_on_the_local_system
    Rembrandt::Engines::Pygmentize.stubs(:present_on_system?).returns(true)
    assert Rembrandt::Engines::Pygmentize.available?
  end
end
