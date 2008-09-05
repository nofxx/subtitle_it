module SubtitleIt
  class SubLine
    attr_accessor :text_on, :text_off, :text
    
    def initialize(text_on, text_off, text)      
      @text_on = Time.parse(text_on)
      @text_off = Time.parse(text_off)
      @text = text
    end
  end
end