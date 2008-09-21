# SubtitleIt
# Time class
module SubtitleIt
  class Subtime
    attr_accessor :hrs, :min, :sec, :ms
        
    def initialize(data) 
      raise if data == nil          
      parse_data(data)
    end
        
    # parses string like '00:00:00,000' or single number as ms.
    def parse_data(data)
      case data
      when Numeric 
        @sec, @ms = data.divmod(1000)
        @min, @sec = @sec.divmod(60)
        @hrs, @min = @min.divmod(60)
      when String 
        time, float = data.split(/\.|\,/)
        time = time.split(/:/).map { |s| s.to_i }
        @ms =  (("0.%d" % float.to_i).to_f * 1000).to_i if float
        @sec, @min, @hrs = time.reverse
      else raise "Format unknown."
      end 
      #FIXME: dunno what to do about this.. nil = problems with to_i
      @hrs ||= 0; @min ||= 0; @sec ||= 0;  @ms ||= 0
    end

    # to_s(separator) => to_s(",") => 00:00:00,000
    def to_s(sep='.'); "%02d:%02d:%02d#{sep}%03d" % [@hrs, @min, @sec,  @ms];    end
    
    # return time as a total in ms
    def to_i;  ( @hrs * 3600 + @min * 60 + @sec ) * 1000 + @ms;    end
    
    def +(other);   Subtime.new(self.to_i + other.to_i);    end    
    def -(other);   Subtime.new(self.to_i - other.to_i);    end    
    def <=>(other);      self.to_i <=> other.to_i;    end
    include Comparable
  end
end