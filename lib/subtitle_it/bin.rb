# SubtitleIt
# Command line tool
module SubtitleIt
  class Subwork
    def run!(file, format)
      fail unless format
      content = File.open(file, 'r')
      STDOUT.puts "Working on file #{file}..."
      sub = Subtitle.new(dump: content, format: Bin.get_extension(file))
      dump = sub.send :"to_#{format}"
      Bin.write_out(Bin.swap_extension(file, format), dump)
    end
  end

  class Subdownloader
    def run!(movie, lang = nil, dst_format = nil)
      @movie = Movie.new(movie)
      @down = Subdown.new
      @down.log_in!
      res = @down.search_subtitles(@movie, lang)
      if res.length == 0
        STDOUT.puts 'No results found.'
        return
      end
      STDOUT.puts 'You can choose multiple ones, separated with spaces or a range separated with hifen.'
      STDOUT.puts "Found #{res.length.to_s.yellow} result#{'s' if res.length > 1}:\n"
      res.sort.each_with_index { |r, i| STDOUT.puts print_option(r, i) }
      STDOUT.printf 'Choose: '
      choose = parse_input(STDIN.gets.chomp)
      choose = choose.map { |c| res[c.to_i - 1] }
      STDOUT.puts "Downloading #{choose.length} subtitle#{'s' if choose.length > 1}..."
      choose.each do |sub|
        down_a_sub(sub, sub.format, dst_format)
      end
      @down.log_out!
    end

    def down_a_sub(sub, format, dst_format)
      dst_format ||= format
      dump = @down.download_subtitle(sub)
      sub = Subtitle.new(dump: dump, format: format)
      dump = sub.send :"to_#{dst_format}" if format != dst_format
      movie_name = @movie.filename[0..-4]
      Bin.write_out(movie_name + dst_format, dump)
    end

    def print_option(r, index)
      "  #{(index + 1).to_s.yellow}. #{r.info['SubLanguageID'].capitalize.green} | #{r.info['SubFormat'].upcase.blue} | #{r.info['MovieName'].cyan} / #{r.info['MovieYear'].cyan} | #{r.info['SubRating'].yellow} | CDs: #{r.info['SubSumCD']}"
    end

    def parse_input(input)
      choose = input.split(' ').map do |c|
        if c =~ /-/
          numbers = c.split('-').map(&:to_i)
          new_range = (numbers[0]..numbers[1]).to_a
        else
          c.to_i
        end
      end
      choose.flatten.uniq
    end
  end

  class Bin
    def self.run!(argv, lang = nil, format = nil, force = false, _delay = nil)
      fail unless argv
      @force = force
      @format = format

      unless File.exist?(argv[0])
        # TODO: generate_rsb
        return
      end

      @file_in = argv[0]
      @file_in_ext = Bin.get_extension(@file_in)
      if argv[1]
        @file_out = argv[1]
        @file_out_ext = Bin.get_extension(@file_out)
        @format = @file_out_ext
      end
      if MOVIE_EXTS.include? @file_in_ext
        Subdownloader.new.run!(@file_in, lang, @format)
      elsif SUB_EXTS.include? @file_in_ext
        Subwork.new.run!(@file_in, @format)
      else
        fail 'Unknown file.'
      end

    rescue Exception => e
      puts e.message
      exit 1
    end

    def self.get_extension(file)
      fail unless file =~ /\./
      file.split('.').last
    end

    def self.swap_extension(file, extension)
      f = file.dup
      f[-3..-1] = extension
      f
    end

    def self.print_languages
      STDOUT.puts 'CODE |  LANGUAGE'
      LANGS.each do |l|
        STDOUT.puts "  #{l[0]}  | #{l[1]}"
      end
    end

    def self.write_out(filename, dump)
      if File.exist?(filename) && !@force
        STDOUT.puts "File exist: #{filename}".red
      else
        File.open(filename, 'w') { |f| f.write(dump) }
        STDOUT.puts "Done: #{filename}.".yellow
      end
    end
  end
end
