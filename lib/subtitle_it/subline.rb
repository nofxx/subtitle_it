require 'rubygems'
require 'chronic'

module SubtitleIt
  class Subline
    attr_accessor :text_on, :text_off, :text
    
    def initialize(text_on, text_off, text)          
      @text_on, @text_off = filter(text_on, text_off)
      @text_on = Chronic.parse(arg)
      @text_off += @text_on if @text_off.instance_of?(Integer)
      
      raise "BadLine" if @text_off < @text_on
      @text = text
    end
    
    def filter(*args)
      args.map do |arg|
        arg = case arg.size
        when 1..3 then return arg.to_i
        when 4 then "00:0#{arg}"                  
        when 5 then "00:#{arg}"      
        else arg
        end
      end
    end
  end
end