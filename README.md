# Rembrandt

A tool for generating syntax-highlighted code, powered by Pygments.

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
