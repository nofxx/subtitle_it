module SubtitleIt
  module Formats
    
    def parse_srt
    end
    
    
    def to_srt
      out = ""
      @lines.each_with_index do |l,i|
        out << "#{i}\n"
        out << "%s --> %s" % [l.text_on.to_s, l.text_off.to_s]
        out << l.text
      end
      out        
    end    
  end
end

# 537
# 00:55:21,600 --> 00:55:27,197
# lt's not even 20 years. You've sold the
# casinos and made fortunes for all of us.