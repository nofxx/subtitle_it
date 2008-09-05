
module SubtitleIt
  class Subline
    attr_accessor :text_on, :text_off, :text
    
    def initialize(text_on, text_off, text)          
      @text_on, @text_off = filter(text_on, text_off)
      @text_off += @text_on if @text_off < @text_on
      @text = text
    end
    
    def filter(*args)
      args.map do |arg|
        Subtime.new(arg)
      end
    end
    
    def stamps
      [@text_on.hour, @text_on.min, @text_on.sec, 
      @text_off.hour, @text_off.min, @text_off.sec]
    end
  end
end