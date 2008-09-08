module SubtitleIt
  module Formats        
    def parse_sub
      @raw.readlines.inject([]) do |i,l|
        text_on, text_off, text = l.gsub(/\{/,'').split("}")        
        i << Subline.new(text_on.to_i, text_off.to_i, text.chomp)
      end
    end
        
    def to_sub
      out = ""
      @lines.each do |l|
        start = l.text_on.to_i / @framerate / 100
        stop = l.text_off.to_i / @framerate / 100
        out << "{%d}{%d}%s" % [start, stop,l.text.gsub("\n", "|")]
      end
      out
    end    
  end 
end


# {1025}{1115}You always say that.|The same thing every time.
# {1118}{1177}"l'm throug h, never again,|too dangerous."