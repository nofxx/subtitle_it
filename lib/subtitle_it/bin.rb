# SubtitleIt
# Command line tool
module SubtitleIt  
  
  class Subwork   
    def run!(file, format)
      raise unless format
      content = File.open(file, 'r')
      puts "Working on file #{file}..."
      sub = Subtitle.new(nil, content, Bin.get_extension(file))       
      dump = sub.send :"to_#{format}" 
      Bin::write_out(Bin.swap_extension(file, format), dump)
    end
  end
    
  class Subdownloader
    def run!(movie)
      @movie = Movie.new(movie)       
      @down = Subdown.new
      @down.log_in!
      res = @down.search_subtitles(@movie)
      puts "Found #{res.length} result#{"s" if res.length > 1}. Choose one:\n"
      res.sort.each_with_index { |r,i| puts print_option(r,i) }
      puts "You can choose multiple ones, separated with spaces or a range separated with hifen."      
      printf "Choose: "  
      choose = parse_input(STDIN.gets.chomp)
      choose = choose.map { |c| res[c.to_i-1] }     
      puts "Downloading #{choose.length} subtitles..."
      choose.each do |sub| 
        down_a_sub(sub, sub.format)
      end
      @down.log_out!
    end
    
    def down_a_sub(sub, format)
      dump = @down.download_subtitle(sub)
      movie_name = @movie.filename[0..-4]
      Bin::write_out(movie_name + format, dump)
    end  

    def print_option(r, index)
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
      raise unless argv
      @force = force
      @format = format
      
      if File.exists?(argv[0]) # && ( argv[1] || format )              
        @file_in = argv[0]
        @file_in_ext = Bin.get_extension(@file_in)        
        if argv[1]
          @file_out = argv[1] 
          @file_out_ext = Bin.get_extension(@file_out)
          @format = @file_out_ext
        end        
        if MOVIE_EXTS.include? @file_in_ext
          Subdownloader.new.run!(argv[0])        
        elsif SUB_EXTS.include? @file_in_ext
          Subwork.new.run!(@file_in, @format)
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
    
    def Bin.get_extension(file)
      raise unless file =~ /\./
      file.split(".").last
    end
    
    def Bin.swap_extension(file,extension)
      f = file.dup
      f[-3..-1] = extension
      f
    end
    
    def Bin.write_out(filename,dump)
      if File.exists?(filename) && !@force
          puts "File exists. #{filename}"
      else
        File.open(filename, 'w') {|f| f.write(dump) }  
        puts "Done. Wrote: #{filename}."
      end
    end
  end
end