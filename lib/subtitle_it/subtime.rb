module SubtitleIt
  class Subtime

    attr_accessor :sec
    
    def initialize(str)      
      @sec = parse_subtime(str)    
    end
    
    
    def parse_subtime(str)
      values = str.split(':').map { |s| s.to_i }
      case values.size
      when 1
        values[0]
      when 2
        values[0] * 60 + values[1]
      when 3
        values[0] * 3600 + values[1] * 60 + values[2]
      else
        raise "Bad Time"
      end
    end
      
    def +(other)
      other.instance_of?(Subtime) ? self.sec + other.sec : self.sec + other
    end
    
    def <=>(other)
      self.sec <=> other.sec
    end
    include Comparable
  end
end