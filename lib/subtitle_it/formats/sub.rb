# SubtitleIt
# MPSub, MicroDVD or VOBSub format
# TODO: tricky.. detect which format we got.
#
# {1025}{1115}You always say that.|The same thing every time.
# {1118}{1177}"l'm throug h, never again,|too dangerous."
#
# MicroDVD:
# {1}{1}25.000
# {2447}{2513}You should come to the Drama Club, too.
# {2513}{2594}Yeah. The Drama Club is worried|that you haven't been coming.
# {2603}{2675}I see. Sorry, I'll drop by next time.
#
# Where N is ms / framerate / 1000 (ms -> s)
#
# parts of the code from 'simplesubtitler' from Marcin (tiraeth) Chwedziak
#
module Formats
  include PlatformEndLine
  # between our formats, what changes can be reduced to a value
  def ratio
    1
  end

  def parse_sub
    @raw.lines.reduce([]) do |i, l|
      line_data = l.scan(/^\{([0-9]{1,})\}\{([0-9]{1,})\}(.+)$/)
      line_data = line_data.at 0
      time_on, time_off, text = line_data
      time_on, time_off = [time_on.to_i, time_off.to_i].map do |t|
        (t.to_i / @fps * 1000 / ratio).to_i
      end
      i << Subline.new(time_on, time_off, text ? text.chomp : nil)
    end
  end

  def to_sub
    endl = endline(@raw)
    line_ary = []
    @lines.each do |l|
      line_ary << '{%d}{%d}%s' % [parse_time(l.time_on), parse_time(l.time_off), l.text]
    end
    line_ary.join(endl) + endl
  end

  def parse_time(n)
    n.to_i / 1000 * @fps * ratio
  end
end
