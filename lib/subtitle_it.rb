$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module SubtitleIt
  include Delay
  
  class Sub
    attr_reader :filename
    
    def initialize(inn,out)                  
      @filename = inn
      @fileout = out      
    end
    

    
  end
  

  
  class Srt < Sub
    
    
    
  end

  
end