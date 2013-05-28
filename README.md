# DotParser

DOT Language file parser.

## Installation

Add this line to your application's Gemfile:

    gem 'dot_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dot_parser

## Usage

```rb
require 'dot_parser'

graph = DotParser.read(ARGF)
p graph
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
