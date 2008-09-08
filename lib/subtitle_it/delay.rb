#!/usr/bin/ruby
# author : Giovanni Rapagnani
# sathyz@gmail.com
module SubtitleIt

  def srt_delay(srt_file, delay)
    puts "Using Subtitle File: #{srt_file}, delay : #{delay}\n"

    if !FileTest::exists?(srt_file)
      print "#{srt_file} doesn't exist.. \n"
      return
    end

    srt_out_file = "delayed.srt"
    srt_out = File.new(srt_out_file,"w")
    puts "Open output file #{srt_out_file}" if $DEBUG
    srt_in = File.new(srt_file,"r")
    puts "Open input file #{srt_file}" if $DEBUG
    seq = "1"
    line = ""

    while (line = srt_in.gets) do
      #line = srt_in.readline() while line.chop!()!=seq
      srt_out.puts( line )
      p line if $DEBUG
      if  line.chop()==seq
        srt_out.puts( delay( srt_in.gets(), delay))
        seq = "%d"%(seq.to_i + 1)
      end
    end

    srt_in.close
    srt_out.close
  end

  def delay(line, delay)
    p "delaying line: #{line}, #{delay}" if $DEBUG
    original_instances = line.split("-->").each{|instance| instance.chop!}

    dir = ( dir = delay.match("^[+-]") ) ? dir[0] : "+" 
    delay = delay.delete(dir)
    p dir if $DEBUG

    delayed_line = "%s --> %s\r\n" % original_instances.collect { |x| eval( x.to_msec + dir + delay.to_msec ).to_time }

    p delayed_line if $DEBUG
    delayed_line
  end

end
# if __FILE__ == $0
#   if ARGV.size != 2
#     print "Usage #{$0} SRT_FILE DELAY\n DELAY specified as 59 => 59 secs, 23:59 => 23 mins 59 secs\n"
#     exit
#   end
#   srt_delay(ARGV[0],ARGV[1])
# end