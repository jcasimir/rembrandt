require './test/test_helper'
require './lib/rembrandt/stores/file'

class StoresFileTest < CodeHighlightTest
  attr_reader :store

  def target
    './tmp/.rembrandt_cache'
  end

  def test_it_creates_the_storage_folder
    `rm -rf #{target}` if Dir.exist?(target)
    refute Dir.exist?(target), "Directory #{target} should not exist."
    @store = Rembrandt::Stores::File.new(target)
    assert Dir.exist?(target), "Directory #{target} should exist."
  end

  def test_it_fetches_data_from_a_file
    sample = "Hello, World!"
    key = "001"
    store = Rembrandt::Stores::File.new(target)
    store.write(key, sample)
    fetched = store.read(key)
    assert_equal sample, fetched
  end

  def teardown
    `rm -rf #{target}/*` if Dir.exist?(target)
  end
end
