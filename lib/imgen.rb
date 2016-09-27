require 'rmagick'
require 'fileutils'

module Imgen
  class Image

    # main entry point
    def initialize(options)
      1.upto(options[:quantity]) do
        img = Magick::Image.new(options[:width], options[:height])
        colors = {r: 0, g: 0, b: 0}
        color_dominant = colors.keys.to_a.sample
        options[:color_dominant] = color_dominant

        make_image(img, options)
      end
    end

    # image processing
    def make_image(img, options)
      last_pixel = {}
      new_pixel = {}

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
              new_pixel[:r] = (options[:color_dominant] == :r) ? rand(0..100) : 0
              new_pixel[:g] = (options[:color_dominant] == :g) ? rand(0..100) : 0
              new_pixel[:b] = (options[:color_dominant] == :b) ? rand(0..100) : 0
              new_pixel[:a] = rand(0..100)
            end
          when :noise
            new_pixel[:r] = (options[:color_dominant] == :r) ? rand(0..100) : 0
            new_pixel[:g] = (options[:color_dominant] == :g) ? rand(0..100) : 0
            new_pixel[:b] = (options[:color_dominant] == :b) ? rand(0..100) : 0
            new_pixel[:a] = rand(0..100)
          end

          img.pixel_color(x,y,"rgba(#{new_pixel[:r]}%, #{new_pixel[:g]}%, #{new_pixel[:b]}%, #{new_pixel[:a]}%)")
          last_pixel = {r: new_pixel[:r], g: new_pixel[:g], b: new_pixel[:b], a: new_pixel[:a]}

          if options[:debug]
            print "R#{new_pixel[:r].to_s.ljust(3)}"
            print "G#{new_pixel[:g].to_s.ljust(3)}"
            print "B#{new_pixel[:b].to_s.ljust(3)}"
            print "A#{new_pixel[:a].to_s.ljust(3)}| "
          end
        end
        print "\n" if options[:debug]
      end

      img_dir = options[:directory]
      img_ext = options[:format]

      unless File.directory?(img_dir)
        FileUtils.mkdir_p(img_dir)
      end

      counter = 0
      img_uniq = "_0"
      filename_path = "#{img_dir}/#{options[:width]}x#{options[:height]}#{img_uniq}.#{img_ext}"

      until !File.exists?(filename_path)
        counter += 1
        img_uniq = "_" + counter.to_s
        filename_path = "#{img_dir}/#{options[:width]}x#{options[:height]}#{img_uniq}.#{img_ext}"
      end

      puts "writing #{filename_path} to disk"
      img.write(filename_path)

      if options[:display]
        begin
          puts "displaying #{filename_path} in X11..."
          img.display
        rescue
          puts "could not display #{filename_path}"
        end
      end
    end

  end
end
