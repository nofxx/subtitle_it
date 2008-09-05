require 'rubygems'
require 'chronic'

module SubtitleIt
  class Subline
    attr_accessor :text_on, :text_off, :text
    
    def initialize(text_on, text_off, text)          
      @text_on, @text_off = filter(text_on, text_off)
      @text_off = @text_on + @text_off.sec if @text_off < @text_on
      @text = text
    end
    
    def filter(*args)
      args.map do |arg|
        puts arg.size
        arg = case arg.size
        when 1 then "00:00:0#{arg}"
        when 2 then "00:00:#{arg}"  
        when 3 then "00:00#{arg}"  
        when 4 then "00:0#{arg}"                  
        when 5 then "00:#{arg}"      
        else arg
        end
        Chronic.parse(arg)
      end
    end
  end
end