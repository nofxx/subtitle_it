$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'rubygems'
require 'subtitle_it/version'
require 'subtitle_it/delay'
require 'subtitle_it/subtime'
require 'subtitle_it/subline'
require 'subtitle_it/subtitle'

module SubtitleIt
 def a
   'hhh'
 end
end

class Numeric
  def reduce
    self / ( 10 ** Math::log10(self).to_i)
  end
end

class String 
  def to_msec
    # convert string in time format to milli sec format 
    # "12:23:34,567" => "12*60*60*1000 + 23*60*1000 + 34 *1000 + 567"
    time_list = self.split(/:/)
    sec, msec = time_list.pop().split(/,|\./) 
    time_list.push(sec)
    p time_list if $DEBUG
    msecs = msec.to_i
    time_list.reverse!
    time_list.each_with_index { |x,i| msecs += x.to_i * 60**i * 1000 }
    p msecs if $DEBUG
    msecs#.to_s
  end
end

class Fixnum
  def to_time()
    # convert millisec to standard time format
    # 3600 * 1000 = ,000
    time = self
    msec = "%.3d" % (time % 1000)
    time /= 1000
    time_list = []
    3.times { time_list.unshift( "%.2d"% (time%60) ) ; time /= 60 }
    p time_list if $DEBUG
    [ time_list.join(':'),msec ].join(',')
  end
end