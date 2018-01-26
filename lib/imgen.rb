require 'rmagick'
require 'fileutils'

module Imgen
  class Image
    MAX = Magick::QuantumRange

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
      last_pixel = {}
      new_pixel = {}

      # iterate over each pixel
      (0..img.columns).each do |x|
        (0..img.rows).each do |y|
          case options[:method]
          when :lines
            if !last_pixel.empty?
              if last_pixel[:color_dominant] == 100
                new_pixel[options[:color_dominant]] = 0
              elsif last_pixel[:color_dominant] == 0
                new_pixel[options[:color_dominant]] = rand(1..10) + last_pixel[options[:color_dominant]]
              else
                new_pixel[options[:color_dominant]] = rand(-10..10) + last_pixel[options[:color_dominant]]
              end
            else
              new_pixel = make_new_pixel(options[:color_dominant])
            end
          when :noise
            new_pixel = make_new_pixel(options[:color_dominant])
          end

          pixel = Magick::Pixel.new(
            new_pixel[:r],
            new_pixel[:g],
            new_pixel[:b],
            new_pixel[:a]
          )

          # change pixel color
          img.pixel_color(x, y, pixel)

          # save values of last color change
          last_pixel = new_pixel

          if options[:debug]
            print "R#{new_pixel[:r].to_s.ljust(3)} "
            print "G#{new_pixel[:g].to_s.ljust(3)} "
            print "B#{new_pixel[:b].to_s.ljust(3)} "
            print "A#{new_pixel[:a].to_s.ljust(3)}|"
          end
        end

        print "\n" if options[:debug]
      end

      write_image_to_file(img, options)

      display_image(img, options)
    end

    # overwrite pixel with new color
    def make_new_pixel(color_dominant)
      clr_strong = rand(0..MAX)

      case color_dominant
      when :r
        new_pixel = {:r => clr_strong, :g => clr_strong / 2, :b => clr_strong / 2}
      when :g
        new_pixel = {:r => clr_strong / 2, :g => clr_strong, :b => clr_strong / 2}
      when :b
        new_pixel = {:r => clr_strong / 2, :g => clr_strong / 2, :b => clr_strong}
      end

      new_pixel[:a] = rand(0..MAX)

      return new_pixel
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

      puts "writing #{options[:filename_path]} to disk"

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
