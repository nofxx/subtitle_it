require 'yaml'

module SubtitleIt
  module Formats
    
    def parse_yml
      @yaml = YAML::load(@raw)
      header = @yaml.delete('header')
      @title = header['title']
      @author = header['authors']
      @version = header['version']

      @yaml['lines'].map { |l| Subline.new(l[0], l[1], l[2]) }
    end
    
  
  
    def to_yml
      YAML.dump(self)
    end
    
  end
end
