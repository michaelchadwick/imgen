# Imgen

[![Gem Version](https://badge.fury.io/rb/imgen.svg)](https://badge.fury.io/rb/imgen)

Imgen is a quick and simple way to create simple, placeholder-type images. One line can make 1, 5, or 100 PNGs, perfect for testing out any project that needs imagery.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imgen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imgen

## Usage

By default, simply running `imgen` will create a single 100x100 PNG, using one of three randomly-selected dominant colors (R, G, or B).

The resulting image will look something like one of the following:

![Imgen default red](https://github.com/michaelchadwick/imgen/blob/master/image-example-red.png) ![Imgen default green](https://github.com/michaelchadwick/imgen/blob/master/image-example-green.png) ![Imgen default blue](https://github.com/michaelchadwick/imgen/blob/master/image-example-blue.png)

You can change width, height, image format, and the quantity of images generated with switches.

`imgen -w 200 -h 300 -f jpg -q 10` - Create 10 200x300 JPGs of random dominant-colored noise.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michaelchadwick/imgen.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
