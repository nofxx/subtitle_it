module SubtitleIt
  module Formats
    
    def parse_srt 
      @raw.read.split(/\n\n/).inject([]) do |i,l|
        l = l.split(/\n/)
        l.delete_at(0)
        timm = l[0].split('-->')
        text_on,text_off = [timm[0].strip, timm[1].strip]#l[0].split('-->').map { |t| t.chomp }#[1].chomp
        l.delete_at(0)        
        text = l.join("\n")
        i << Subline.new(text_on, text_off, text)
      end
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