# SubtitleIt
# RSB - Ruby Subtitle
#
# 00:32 => 00:33 == Nice police work! | Thank you!
# 00:53 => N == Howdy ho!
# MM:SS => N == TEXT | NEWLINE
#
# Where N is the seconds to last.
#
module SubtitleIt
  module Formats
    def parse_rsb
      inn = @raw.readlines
      @title = inn.delete_at(0).split(':')[1] 
      @authors = inn.delete_at(0).split(':')[1] 
      @version = inn.delete_at(0).split(':')[1] 
      inn.inject([]) do |final,line|
        text_on,text_off = line.split('=>').map { |t| t.strip }
        text = line.split('==')[1].strip
        final << Subline.new(text_on, text_off, text)
      end
    end
    
    def to_rsb
      out = "- title: #{@title}\n- authors: #{@authors}\n- version: #{@version}\n"
      out << @lines.inject([]) do |i,l|
        i << "%s => %s == %s" % [l.text_on.to_s, l.text_off.to_s, l.text]
      end.join("\n")      
    end    
  end
end


