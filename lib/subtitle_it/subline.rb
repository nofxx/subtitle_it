
module SubtitleIt
  class Subline
    attr_accessor :text_on, :text_off, :text
    
    def initialize(text_on, text_off, text)          
      @text_on, @text_off = filter(text_on, text_off)
      @text_off.sec += @text_on.sec if @text_off < @text_on
      @text = text
    end
    
    def filter(*args)
      args.map do |arg|
        Subtime.new(arg)
      end
    end
  end
end