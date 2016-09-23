require 'rmagick'
require 'fileutils'

module Imgen
  class Image

    # main entry point
    def initialize(options)
      img = Magick::Image.new(options[:width].to_i, options[:height].to_i)
      colors = {r: 0, g: 0, b: 0}

      color_dominant = colors.keys.to_a.sample

      (0..img.columns).each do |x|
        (0..img.rows).each do |y|
          red = (color_dominant == :r) ? rand(0..100) : 0
          green = (color_dominant == :g) ? rand(0..100) : 0
          blue = (color_dominant == :b) ? rand(0..100) : 0
          alpha = rand(0..100)
          img.pixel_color(x,y,"rgba(#{red}%, #{green}%, #{blue}%, #{alpha}%)")
        end
      end

      img_dir = "img"
      img_ext = "png"

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
