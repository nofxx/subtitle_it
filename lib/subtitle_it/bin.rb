# SubtitleIt
# Command line tool
module SubtitleIt
  class Subwork
    def run!(file, format)
      fail unless format
      content = File.open(file, 'r')
      puts "Working on file #{file}..."
      sub = Subtitle.new(dump: content, format: Bin.get_extension(file))
      dump = sub.send :"to_#{format}"
      Bin.write_out(Bin.swap_extension(file, format), dump)
    end
  end

  class Subdownloader
    def run!(movie, lang = nil, dst_format = nil, first = false)
      @movie = Movie.new(movie)
      @down = Subdown.new
      @down.log_in!
      res = @down.search_subtitles(@movie, lang).sort
      if res.length == 0
        puts 'No results found.'
        return
      end
      unless first
        puts "Found #{res.size.to_s.yellow} result#{'s' if res.size > 1}:\n"
        res.each_with_index { |r, i| puts print_option(r.info, i) }
        puts 'You can choose multiple ones separated with spaces: 1 3 5 '
        puts 'Or a range separated with a hifen: 3-5'
        STDOUT.print "Choose (1..#{res.size}): "
        choose = parse_input(STDIN.gets.chomp)
        choose = choose.map { |c| res[c.to_i - 1] }
      else
        choose = [res.first]
      end
      puts "Downloading #{choose.size} subtitle#{'s' if choose.size > 1}..."
      choose.each do |sub|
        down_a_sub(sub, dst_format)
      end
      @down.log_out!
    end

    def down_a_sub(sub, dst_format)
      dst_format ||= sub.format
      dump = @down.download_subtitle(sub)
      if sub.format != dst_format
        subt = Subtitle.new(dump: dump, format: sub.format)
        dump = subt.send :"to_#{dst_format}"
      end
      fname = @movie.filename[0..-4] + sub.info['SubLanguageID']
      Bin.write_out("#{fname}.#{dst_format}", dump)
    end

    def print_option(r, index)
      date = Date.parse(r['SubAddDate'])
      "  #{(index + 1).to_s.rjust(2, ' ').yellow}."\
      " #{r['LanguageName'][0, 9].rjust(10, ' ').green}"\
      " | #{r['SubFormat'].upcase.blue} | #{r['MovieName'][0, 20].cyan}"\
      " / #{r['MovieYear'].cyan} | #{r['SubRating'].yellow}"\
      " | FPS #{r['MovieFPS']} | #{r['SubSumCD']} CDs | #{date}"
    end

    def parse_input(input)
      choose = input.split(' ').map do |c|
        if c =~ /-/
          numbers = c.split('-').map(&:to_i)
          (numbers[0]..numbers[1]).to_a
        else
          c.to_i
        end
      end
      choose.flatten.uniq
    end
  end

  class Bin
    def self.run!(argv, lang = nil, format = nil, force = false, _delay = nil, first = false)
      fail unless argv

      @lang = lang
      @force = force
      @format = format
      @first = first

      # TODO: generate_rsb
      unless File.exist?(argv[0])
        puts "Can't find '#{argv.join}'".yellow
        exit 1
      end

      @file_in = argv[0]
      @file_in_ext = Bin.get_extension(@file_in)
      if argv[1]
        @file_out = argv[1]
        @file_out_ext = Bin.get_extension(@file_out)
        @format = @file_out_ext
      end

      if MOVIE_EXTS.include? @file_in_ext
        Subdownloader.new.run!(@file_in, @lang, @format, @first)
      elsif SUB_EXTS.include? @file_in_ext
        Subwork.new.run!(@file_in, @format)
      else
        fail "Unknown file type '#{@file_in_ext}'."
      end
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
      puts 'CODE |  LANGUAGE'
      LANGS.each do |l|
        puts "  #{l[0]}  | #{l[1]}"
      end
    end

    def self.write_out(filename, dump)
      if File.exist?(filename) && !@force
        puts "File exist: #{filename}".red
      else
        File.open(filename, 'w') { |f| f.write(dump) }
        puts "Done: #{filename}".yellow
      end
    end
  end
end
