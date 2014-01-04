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

### Basic Highlighting

```irb
> require 'rembrandt'
> highlighter = Rembrandt::Highlighter.new
> highlighter.highlight("class Sample\nend", "ruby")
```

### Highlighting Source in a File

```irb
> require 'rembrandt'
> highlighter = Rembrandt::Highlighter.new
> highlighter.highlight_file("./my_input_file.rb", "ruby")
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
