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

By default, simply running `imgen` will create a single 100x100 PNG, using a randomly-selected color.

The resulting image will look something like one of the following:

![Imgen solid example 1](https://github.com/michaelchadwick/imgen/blob/master/imgen-solid-example-1.png) ![Imgen solid example 2](https://github.com/michaelchadwick/imgen/blob/master/imgen-solid-example-2.png) ![Imgen solid example 3](https://github.com/michaelchadwick/imgen/blob/master/imgen-solid-example-3.png)

You can change width, height, image format, and the quantity of images generated with switches.

`imgen -m texture -w 200 -h 300 -f jpg -q 3` - Create 3 200x300 JPGs of randomly-chosen textured color.

![Imgen texture example 1](https://github.com/michaelchadwick/imgen/blob/master/imgen-texture-example-1.png) ![Imgen texture example 2](https://github.com/michaelchadwick/imgen/blob/master/imgen-texture-example-2.png) ![Imgen texture example 3](https://github.com/michaelchadwick/imgen/blob/master/imgen-texture-example-3.png)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michaelchadwick/imgen.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
