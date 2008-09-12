# SubtitleIt
# Command line tool
module SubtitleIt  
  
  class Subwork   
    def run!(file,ext,format)
      filename = file + ext
      content = File.open(filename, 'r')
      puts "Working on file #{filename}..."
      sub = Subtitle.new(content, ext)       
      dump = sub.send :"to_#{format}" 
      Bin::write_out(file+format, dump)
    end
  end
    
  class Subdownloader
    def run!(movie)
      @movie = Movie.new(movie)       
      @down = Subdown.new
      @down.log_in!
      res = @down.search_subtitles(@movie)
      puts "Found #{res.length} result#{"s" if res.length > 1}. Choose one:\n"
      res.each_with_index { |r,i| puts print_choice(r,i) }
      puts "You can choose multiple ones, separated with spaces or a range separated with hifen."      
      printf "Choose: "  
      choose = parse_input(STDIN.gets.chomp)
      choose = choose.map { |c| res[c.to_i-1] }     
      puts "Downloading #{choose.length} subtitles..."
      choose.each do |sub| 
        puts "#{sub.inspect}"
        down_a_sub(sub, sub.format)
      end
      @down.log_out!
    end
    
    def down_a_sub(sub, format)
      dump = @down.download_subtitle(sub)
      movie_name = Bin.parse_file(@movie.filename)[0]
      Bin::write_out("#{movie_name}.#{format}", dump)
    end  

    def print_choice(r, index)
      c = "#{index+1}) #{r.info["MovieName"]} / #{r.info["MovieYear"]} | #{r.info["SubFileName"]} | Movie score: #{r.info["MovieImdbRating"]}\n"
      c << "   Lang: #{r.info["SubLanguageID"].capitalize} | Format: #{r.info["SubFormat"].upcase} | Downloads: #{r.info["SubDownloadsCnt"]} | Rating: #{r.info["SubRating"]} | CDs: #{r.info["SubSumCD"]}\n"
      c << "   Comments: #{r.info["SubAuthorComment"]} \n\n"
    end
    
    def parse_input(input)
      choose = input.split(" ").map do |c|
        if c =~ /-/
          numbers = c.split("-").map { |d| d.to_i }
          new_range = (numbers[0]..numbers[1]).to_a
        else
          c.to_i
        end
      end
      choose.flatten.uniq
    end    
  end

  class Bin   

    def Bin.run! argv, format=nil, force=false, delay=nil
#      SubtitleIt::Bin.new.run!(argv, format, force, delay)
      raise unless argv
      if File.exists?(argv[0]) # && ( argv[1] || format )              
        @file_in, @file_in_ext = Bin::parse_file(argv[0])
        @file_out, @fileout_ext = argv[1] ? Bin::parse_file(argv[1]) : [@file_in, @file_in_ext]
        if MOVIE_EXTS.include? @file_in_ext
          Subdownloader.new.run!(argv[0])
        elsif SUB_EXTS.include? @file_in_ext
          Subwork.new.run!(@file_in, @file_in_ext, format)
        else
          raise "Unknown file."
        end
      else
#        generate_rsb
      end
    rescue Exception => e
      puts e.message
      exit 1
    end
    
    def Bin.parse_file(file)
      raise unless file =~ /\./
      file = file.split('.')
      ext = file.delete_at(-1)
      file = file.join('.')
      [file, ext]      
    end
    
    def Bin.write_out(filename,dump,force=nil)
      if File.exists?(filename) && !force
          puts "File exists. #{filename}"
      else
        File.open(filename, 'w') {|f| f.write(dump) }  
        puts "Done. Wrote: #{filename}."
      end
    end
  end
end