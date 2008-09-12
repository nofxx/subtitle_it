# SubtitleIt
# Holds a subtitle`s line.
module SubtitleIt
  class Subline
    attr_accessor :time_on, :time_off, :text    
    # time_on/off may be:
    # HH:MM:SS,MMM
    # MM:SS
    # S 
    # text lines should be separated by |
    def initialize(time_on, time_off, text)          
      @time_on, @time_off = filter(time_on, time_off)
      # ugly FIXME: when pseudo uses time => 3 or TT format
      # need to add seconds on time_off to time_on
      @time_off += @time_on if @time_off < @time_on
      @text = text
    end
    
    def filter(*args)
      args.map do |arg|
        Subtime.new(arg)
      end
    end
  end
end