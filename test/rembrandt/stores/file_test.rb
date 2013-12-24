require './test/test_helper'
require './lib/rembrandt/stores/file'

class StoresFileTest < CodeHighlightTest
  attr_reader :store

  def test_it_creates_the_storage_folder
    target = './tmp/.rembrandt_cache'
    `rm -rf #{target}` if Dir.exist?(target)
    refute Dir.exist?(target), "Directory #{target} should not exist."
    @store = Rembrandt::Stores::File.new(target)
    assert Dir.exist?(target), "Directory #{target} should exist."
  end
end
