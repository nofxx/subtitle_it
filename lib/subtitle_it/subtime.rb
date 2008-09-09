# SubtitleIt
# Time class
module SubtitleIt
  class Subtime
    attr_accessor :hrs, :min, :sec, :ms
        
    def initialize(sym)  
      @hrs = @min = @sec = @ms = 0    
      parse_subtime(sym)    
    end
        
    # parses string like '00:00:00,000'
    # as well as an integer, representanting 
    # the time in ms. 
    def parse_subtime(sym)
      if sym.kind_of?(Numeric)
        @hrs = sym / 3600000
        @min = sym / 60000 % 600
        @sec = sym / 1000 % 60
        @ms = sym % 1000
        return
      end
      v = sym.split(/\.|\,/)
      if ms = v[1]  
        @ms =  (("0.%d" % ms.to_i).to_f * 1000).to_i
      end
      v = v[0].split(/:/).map { |s| s.to_i }      
      case v.size
      when 1
        @sec = v.first
      when 2
        @min, @sec = v
      when 3
        @hrs, @min, @sec = v
      else
        raise "Wrong time format"
      end
    end
    
    # to_s(separator) => to_s(",") => 00:00:00,000
    def to_s(sep='.')
      "%02d:%02d:%02d#{sep}%03d" % [@hrs, @min, @sec,  @ms]
    end
    
    # return time as a total in ms
    def to_i
      ( @hrs * 3600 + @min * 60 + @sec ) * 1000 + @ms
    end
    
    def +(other)
       Subtime.new(self.to_i + other.to_i)
    end
    
    def -(other)
       Subtime.new(self.to_i - other.to_i)
    end
    
    def <=>(other)
      self.to_i <=> other.to_i
    end
    include Comparable
  end
end