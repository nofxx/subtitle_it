module SubtitleIt
  module Formats    
    def parse_srt 
      @raw.read.split(/\n\n/).inject([]) do |final,line|
        line = line.split(/\n/)
        line.delete_at(0)
        text_on,text_off = line[0].split('-->').map { |t| t.strip }
        line.delete_at(0)        
        text = line.join("\n")
        final << Subline.new(text_on, text_off, text)
      end
    end

    def to_srt
      out = ""
      @lines.each_with_index do |l,i|
        out << "#{i}\n"
        out << "%s --> %s\n" % [l.text_on.to_s, l.text_off.to_s]
        out << l.text + "\n"
      end
      out        
    end    
  end
end

# 537
# 00:55:21,600 --> 00:55:27,197
# lt's not even 20 years. You've sold the
# casinos and made fortunes for all of us.