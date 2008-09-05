$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'yaml'

module SubtitleIt
  include Delay
  
  class Sub
    attr_reader :filename
    
    def initialize(inn,out)
      @filename = inn
      @fileout = out
    end
    
    private
    
    def parse_yml
      @yaml_file = File.open(inn) { |yf| YAML::load(yl) }
      
      @title = @yaml_file['header']['title']
      @author = @yaml_file['header']['author']
      @version = @yaml_file['header']['version']
      
      @text = @yaml_file['content'].collect { |l| SubLine.new(l[0], l[1], l[3]) }
    end
        
  end
  
  class SubLine
    attr_accessor(:text_on, :text_off, :text)
    
    def initialize(text_on, text_off, text)
      @text_on = text_on; @text_off = text_off; @text = text
    end
  end
  
  class Srt < Sub
    
  end

  
end
