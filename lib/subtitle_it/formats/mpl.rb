# SubtitleIt
# MPL2 - extension .txt
#
# [1025][1115]You always say that.|The same thing every time.
#
# Where N is sec * 10
#
module Formats       
  include PlatformEndLine
  def parse_mpl
    @raw.to_a.inject([]) do |i,l|
		      line_data = l.scan(/^\[([0-9]{1,})\]\[([0-9]{1,})\](.+)$/)
		      line_data = line_data.at 0
		      time_on, time_off, text = line_data
		      time_on, time_off = [time_on.to_i, time_off.to_i].map { |t| t.to_i * 1000 }	    
      i << Subline.new(time_on, time_off, text.chomp)
    end
  end
      
  def to_mpl
    endl = endline( @raw )
    line_ary = []
    @lines.each do |l|
      start, stop = [l.time_on, l.time_off].map { |val| val.to_i / 100 }
      line_ary << "[%d][%d]%s" % [start, stop, l.text]
    end
    return line_ary.join( endl ) + endl
  end    
end 
