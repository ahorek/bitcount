# Bitcount

__builtin_popcount - Returns the number of 1 bits
```ruby
         1 => 00000000000000000000000000000001 => 1
2147483648 => 10000000000000000000000000000000 => 1
2147500033 => 10000000000000000100000000000001 => 3
```

__builtin_clz - Returns leading zeros

```ruby
         1 => 00000000000000000000000000000001 => 31
2147483648 => 10000000000000000000000000000000 => 0
2147500033 => 10000000000000000100000000000001 => 0
```

__builtin_ctz - Returns trailing zeros

```ruby
         1 => 00000000000000000000000000000001 => 0
2147483648 => 10000000000000000000000000000000 => 31
2147500033 => 10000000000000000100000000000001 => 0
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitcount'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bitcount

## Usage
```ruby
require 'bitcount'
Bitcount.popcount(1)
=> 1

Bitcount.nlz(1)
=> 63

Bitcount.ntz(1)
=> 0
```

or

```ruby
require 'bitcount/integer'
1.popcount
=> 1

1.nlz
=> 63

1.ntz
=> 0
```

you can specify a different layout, but if the layout doesn't match your platform a slower version will be used
```ruby
1.nlz(32)
=> 31

Bitcount::Native.layout_size
=> 64
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ahorek/bitcount.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
