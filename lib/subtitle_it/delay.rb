#!/usr/bin/ruby
# author : sathyz@gmail.com
#
module SubtitleIt

  class String 
    def to_msec( )
      # convert string in time format to milli sec format 
      # "12:23:34,567" => "12*60*60*1000 + 23*60*1000 + 34 *1000 + 567"
      time_list = self.split(":")
      sec, msec = time_list.pop().split(",") 
      time_list.push(sec)
      p time_list if $DEBUG
      msecs = msec.to_i
      time_list.reverse!
      time_list.each_with_index { |x,i| msecs += x.to_i * 60**i * 1000 }
      p msecs if $DEBUG
      msecs.to_s
    end
  end

  class Fixnum

    def to_time()
      # convert millisec to standard time format
      # 3600 * 1000 = ,000
      time = self
      msec = "%.3d"%(time % 1000)
      time /= 1000
      time_list = []
      3.times { time_list.unshift( "%.2d"% (time%60) ) ; time /= 60 }
      p time_list if $DEBUG
      [ time_list.join(':'),msec ].join(',')
    end

  end

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