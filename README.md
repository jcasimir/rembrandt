# Rembrandt

Rembrandt is a library for generating and caching syntax-highlighted code. Highlighting is powered by Pygments, either running locally or over a web API. Caching is handled either by Redis or the local file system.

## Installation

Add this line to your application's Gemfile:

    gem 'rembrandt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rembrandt

## Usage

### Pygments Local vs API

The library will run `which pygmentize` to check if Pygments is installed locally. If it is, the library will use it. If it is not, the library will attempt to use the web-api at http://pygmentize.herokuapp.com

### Storage with Redis or the Filesystem

If you'd like to use Redis as the datastore, there are two steps:

* Add the `redis` gem to your bundle
* Define an environment variable with the redis address

The environment variable `REMBRANDT_REDIS_URL`. On a unix system you can do this with the `export` instruction at your terminal:

```plain
export REMBRANDT_REDIS_URL='redis://my_user_name:my_password@example.com:9352/'
```

To verify the environment variable, open `irb` and try to access it:

```plain
$ irb
> 2.0.0-p353 :001 > ENV['REMBRANDT_REDIS_URL']
=> "redis://my_user_name:my_password@example.com:9352/" 
```

If Redis is *not* required and/or the environment variable is *not* defined, the library will use the local filesystem.

### Basic Highlighting

```irb
> require 'rembrandt'
> highlighter = Rembrandt::Highlighter.new
> highlighter.highlight("class Sample\nend", "ruby")
```

### Highlighting Source from a File

```irb
> require 'rembrandt'
> highlighter = Rembrandt::Highlighter.new
> highlighter.highlight_file("./my_input_file.rb", "ruby")
```

### Usage with Octopress

Octopress has some really complex things going on in `plugins/pygments.rb` and `plugins/highlight_code.rb` and `plugins/backtick_code_block.rb`. Let's simplify.

* Delete `plugins/highlight_code.rb`
* Delete `plugins/pygments_code.rb`
* Replace `plugins/backtick_code_block.rb` with the following:

```ruby
module BacktickCodeBlock
  def render_code_block(input)

  end

  def highlighter
    @highlighter ||= Rembrandt::Highlighter.new
  end

  def formatter
    @formatter ||= Rembrandt::Formatters::Octopress.new
  end
```

### Using a Formatter

```irb
> require 'rembrandt'
> highlighter = Rembrandt::Highlighter.new
> formatter = Rembrandt::Formatters::Table.new
> code = highlighter.highlight("class Sample\nend", "ruby")
> table = formatter.format(code, "ruby")
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### When Developing

It's expected that when developing that you have both Redis and Python/Pygmentize available on your machine. If you don't have Pygments installed, Rembrant's tests will try to use the HTTP highlight engine which is blocked by VCR.
