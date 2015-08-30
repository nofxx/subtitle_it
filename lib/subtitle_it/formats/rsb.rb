# SubtitleIt
# RSB - Ruby Subtitle
#
# 00:32 => 00:33
# Nice police work! | Thank you!
# 00:53 => N == Howdy ho!
# MM:SS => N == TEXT | NEWLINE
#
# Where N is the seconds to last.
#
module Formats
  include PlatformEndLine
  def parse_rsb
    inn = @raw.lines
    @title = inn.delete_at(0).split(':')[1]
    @authors = inn.delete_at(0).split(':')[1]
    @version = inn.delete_at(0).split(':')[1]
    inn.inject([]) do |final, line|
      time_on, time_off = line.split('=>').map(&:strip)
      text = line.split('==')[1] # .strip
      final << Subline.new(time_on, time_off, text ? text.strip : nil)
    end
  end

  def to_rsb
    endl = endline(@raw)
    out = ["- title: #{@title}", "- authors: #{@authors}", "- version: #{@version}"]
    @lines.each do |l|
      out << '%s => %s == %s' % [l.time_on.to_s, l.time_off.to_s, l.text]
    end
    out.join(endl) + endl
    # out = "- title: #{@title}\n- authors: #{@authors}\n- version: #{@version}\n"
    # out << @lines.inject([]) do |i,l|
    #  i << "%s => %s == %s" % [l.time_on.to_s, l.time_off.to_s, l.text]
    # end.join("\n")
  end
end
