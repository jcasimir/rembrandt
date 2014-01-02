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

  def test_it_flushes_the_database
    store.write("002", "Hello")
    assert store.read("002")
    store.flush
    refute store.read("002"), "All keys should be gone"
  end

  def test_fetch_does_not_write_when_there_is_no_block
    refute store.fetch("hello", "ruby"), "hello should not be found"
    key = store.key_for("hello", "ruby")
    refute store.read(key), "hello should not have been written"
  end

  def test_fetch_writes_the_result_of_a_block
    refute store.fetch("hello", "ruby")
    result = store.fetch("hello", "ruby"){ "Hello, World" }
    assert_equal "Hello, World", result
    key = store.key_for("hello", "ruby")
    assert_equal result, store.read(key)
  end

  def test_it_uses_a_redis_url_in_an_environment_variable
    url =  "redis://redisuser:redispassword@provider.example.com:9352/"
    ENV['REMBRANDT_REDIS_URL'] = url
    store2 = Rembrandt::Stores::Redis.new
    assert_equal url, store2.url
    ENV['REMBRANDT_REDIS_URL'] = ''
  end

  def teardown
    store.flush
  end
end
