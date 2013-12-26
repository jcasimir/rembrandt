require './test/test_helper'
require './lib/rembrandt/stores/file'
require './lib/rembrandt/config'

class StoresFileTest < CodeHighlightTest
  attr_reader :store

  def target
    Rembrandt::Config.file_store_directory
  end

  def setup
    @store = Rembrandt::Stores::File.new
  end

  def test_it_creates_the_storage_folder
    `rm -rf #{target}` if Dir.exist?(target)
    refute Dir.exist?(target), "Directory #{target} should not exist."
    store = Rembrandt::Stores::File.new(target)
    assert Dir.exist?(target), "Directory #{target} should exist."
  end

  def test_it_fetches_data_from_a_file
    sample = "Hello, World!"
    key = "001"
    store.write(key, sample)
    fetched = store.read(key)
    assert_equal sample, fetched
  end

  def test_it_calculates_keys
    sample = "Hello, World!"
    assert store.key_for(sample, 'ruby')
  end

  def test_it_uses_the_configured_output_directory
    Rembrandt::Config.file_store_directory = './tmp/'
    store2 = Rembrandt::Stores::File.new
    assert_equal './tmp/', store2.output_directory
  end

  def teardown
    store.flush
  end
end
