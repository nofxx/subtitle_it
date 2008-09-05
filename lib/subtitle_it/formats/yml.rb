require 'yaml'

module SubtitleIt
  module Formats
    
    def parse_yml
      @yaml = YAML::load(@raw)
     
      header = @yaml.delete(:header)
      @title = header[:title]
      @author = header[:authors]
      @version = header[:version]
      
      @yaml[:content].map { |l| SubLine.new(l[0], l[1], l[3]) }
    end
    
  
  
    def to_yml
      
    end
    
  end
end
