require 'rmagick'
require 'fileutils'

module Imgen
  class Image

    # main entry point
    def initialize(options)
      1.upto(options[:quantity]) do
        img = Magick::Image.new(options[:width].to_i, options[:height].to_i)
        colors = {r: 0, g: 0, b: 0}
        color_dominant = colors.keys.to_a.sample
        options[:color_dominant] = color_dominant

        make_image(img, options)
      end
    end

    # image processing
    def make_image(img, options)
      (0..img.columns).each do |x|
        (0..img.rows).each do |y|
          red = (options[:color_dominant] == :r) ? rand(0..100) : 0
          green = (options[:color_dominant] == :g) ? rand(0..100) : 0
          blue = (options[:color_dominant] == :b) ? rand(0..100) : 0
          alpha = rand(0..100)
          img.pixel_color(x,y,"rgba(#{red}%, #{green}%, #{blue}%, #{alpha}%)")
        end
      end

      img_dir = options[:directory]
      img_ext = options[:format]

      unless File.directory?(img_dir)
        FileUtils.mkdir_p(img_dir)
      end

      counter = 0
      img_uniq = ""
      filename_path = "#{img_dir}/#{options[:width]}x#{options[:height]}#{img_uniq}.#{img_ext}"

      until !File.exists?(filename_path)
        counter += 1
        img_uniq = "_" + counter.to_s
        filename_path = "#{img_dir}/#{options[:width]}x#{options[:height]}#{img_uniq}.#{img_ext}"
      end

      puts "writing #{filename_path} to disk"
      img.write(filename_path)

      if options[:display]
        puts "displaying #{filename_path} in X11..."
        img.display
      end
    end

  end
end
