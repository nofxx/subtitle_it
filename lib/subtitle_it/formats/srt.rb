# SubtitleIt
# SRT format
#
# N
# 00:55:21,600 --> 00:55:27,197
# lt's not even 20 years. You've sold the
# casinos and made fortunes for all of us.
#
# Where N is the sub index number
#
module SubtitleIt
  module Formats    
    def parse_srt 
      @raw.split(/\n\n/).inject([]) do |final,line|
        line = line.split(/\n/)
        line.delete_at(0)
        text_on,text_off = line[0].split('-->').map { |t| t.strip }
        line.delete_at(0)        
        text = line.join("|")
        final << Subline.new(text_on, text_off, text)
      end
    end

    def to_srt
      out = []
      @lines.each_with_index do |l,i|
        out << "#{i}"
        out << "%s --> %s" % [l.text_on.to_s, l.text_off.to_s]
        out << l.text.gsub("|","\n")
      end
      out.join("\n")
    end    
  end
end