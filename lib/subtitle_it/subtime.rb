module SubtitleIt
  class Subtime
    attr_writer :sec
    
    def initialize(str)      
      @sec = parse_subtime(str)    
    end
        
    def parse_subtime(str)
      return str if str.instance_of?(Fixnum)
      values = str.split(/:|,|\./).map { |s| s.to_i }
      case values.size
      when 1
        values[0]
      when 2
        values[0] * 60 + values[1]
      when 3
        values[0] * 3600 + values[1] * 60 + values[2]
      else
        str.to_i
      end
    end
    
    def hour
      @sec / 3600
    end
    
    def min
      m = @sec / 60
      m % 60
    end
    
    def sec
      @sec % 60
    end
    
    def +(other)
       @sec += other.sec# : self.sec + other
    end
    
    def <=>(other)
      self.sec <=> other.sec
    end
    include Comparable
  end
end