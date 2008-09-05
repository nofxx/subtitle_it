module SubtitleIt
  class Subtime
    attr_accessor :sec_raw
    
    def initialize(str)      
      @sec_raw = parse_subtime(str)    
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
      @sec_raw / 3600
    end
    
    def min
      m = @sec_raw / 60
      m % 60
    end
    
    def sec
      @sec_raw % 60
    end
    
    def +(other)
       @sec_raw = other.sec_raw 
    end
    
    def <=>(other)
      self.sec_raw <=> other.sec_raw
    end
    include Comparable
  end
end