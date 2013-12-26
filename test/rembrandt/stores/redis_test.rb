require './test/test_helper'
require './lib/rembrandt/stores/redis'

class StoresRedisTest < CodeHighlightTest
  attr_reader :store

  def setup
    @store = Rembrandt::Stores::Redis.new
  end

  def test_it_is_not_available_when_redis_is_not_loaded
    Object.const_set('REAL_REDIS', Redis)
    Object.send(:remove_const, :Redis)
    refute store.available?
    Object.const_set('Redis', REAL_REDIS)
  end

  def test_it_is_available_when_redis_is_loaded
    assert store.available?, "Redis should be available when required"
  end

  def test_it_fetches_data
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

  def teardown
    store.flush
  end
end
