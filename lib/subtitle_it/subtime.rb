module SubtitleIt
  class Subtime
    attr_accessor :hrs, :min, :sec, :ds
    # 10e–1 second =>	ds =>	decisecond
    # 11ds => 00:00:01.100
    # 1ds => 00:00:00.100
    # 611ds => 00:01:01.100
        
    def initialize(sym)  
      @hrs = @min = @sec = @ds = 0    
      parse_subtime(sym)    
    end
        
    def parse_subtime(sym)
      if sym.kind_of?(Numeric)
        @hrs = sym / 36000
        @min = sym / 600 % 600
        @sec = sym / 10 % 60
        @ds = sym % 10
        return
      end
      v = sym.split(/\.|,/)
      @ds = v[1].to_i.reduce if v[1]      
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
       
    def to_s
      "%02d:%02d:%02d.%s" % [@hrs, @min, @sec, ("%03d" % @ds).reverse ]
    end
    
    def to_i
      (@hrs * 3600 + @min * 60 + @sec) * 10 + @ds
    end
  
    
    def +(other)
       Subtime.new(self.to_i + other.to_i)
    end
    
    def <=>(other)
      self.to_i <=> other.to_i
    end
    include Comparable
  end
end