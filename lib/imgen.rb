require 'rmagick'
require 'fileutils'
require_relative 'imgen/color_names'

module Imgen
  class Image
    # main entry point
    def initialize(options)
      1.upto(options[:quantity]) do
        img = Magick::Image.new(options[:width], options[:height])
        #img.colorspace = Magick::RGBColorspace
        colors = {r: 0, g: 0, b: 0}
        options[:color_dominant] = colors.keys.to_a.sample

        make_image(img, options)
      end
    end

    # image processing
    def make_image(img, options)
      index_range = (-5..5)
      color_name_index = rand(0..COLOR_NAMES.length - 1)

      # iterate over each pixel
      (0..img.columns).each do |x|
        (0..img.rows).each do |y|
          case options[:method]
          when :solid
            pixel = make_new_pixel(COLOR_NAMES[color_name_index])
          when :texture
            new_color_name_index = (color_name_index + rand(index_range))

            # fix boundary of index
            if new_color_name_index < 0
              color_name_index = 0
            elsif new_color_name_index >= COLOR_NAMES.length
              color_name_index = COLOR_NAMES.length - 1
            else
              color_name_index = new_color_name_index
            end

            pixel = make_new_pixel(COLOR_NAMES[color_name_index])
          end

          # save pixel color
          img.pixel_color(x, y, pixel)
        end
      end

      write_image_to_file(img, options)

      display_image(img, options)
    end

    # create new Pixel from color name
    def make_new_pixel(new_name)
      return Magick::Pixel.from_color(new_name)
    end

    # write image to disk
    def write_image_to_file(img, options)
      img_dir = options[:directory]
      img_ext = options[:format]

      unless File.directory?(img_dir)
        FileUtils.mkdir_p(img_dir)
      end

      counter = 0
      img_uniq = "_0"
      options[:filename_path] = "#{img_dir}/#{options[:width]}x#{options[:height]}#{img_uniq}.#{img_ext}"

      until !File.exists?(options[:filename_path])
        counter += 1
        img_uniq = "_" + counter.to_s
        options[:filename_path] = "#{img_dir}/#{options[:width]}x#{options[:height]}#{img_uniq}.#{img_ext}"
      end

      puts "writing #{options[:filename_path]} to disk" if options[:verbose]

      begin
        img.write(options[:filename_path])
      rescue
        puts 'error writing image to disk'
      end
    end

    # optionally display image after creation
    def display_image(img, options)
      if options[:display_x11]
        begin
          img.display
        rescue
          puts "could not display #{options[:filename_path]}"
        end
      elsif options[:display_imgcat]
        begin
          system("imgcat #{options[:filename_path]}")
        rescue
          puts "could not display #{options[:filename_path]}"
        end
      end
    end
  end
end
