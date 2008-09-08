# SubtitleIt
# Holds a subtitle`s line.
module SubtitleIt
  class Subline
    attr_accessor :text_on, :text_off, :text    
    # text_on/off may be:
    # HH:MM:SS,MMM
    # MM:SS
    # S 
    # text lines should be separated by |
    def initialize(text_on, text_off, text)          
      @text_on, @text_off = filter(text_on, text_off)
      # ugly FIXME: when pseudo uses time => 3
      # need to add seconds from the first sub
      @text_off += @text_on if @text_off < @text_on
      @text = text
    end
    
    def filter(*args)
      args.map do |arg|
        Subtime.new(arg)
      end
    end
  end
end