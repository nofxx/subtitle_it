# SubtitleIt
# XML TT Timed Text
# http://www.w3.org/TR/2006/CR-ttaf1-dfxp-20061116/
# http://livedocs.adobe.com/flash/9.0/main/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=00000604.html
#
# <?xml version="1.0" encoding="UTF-8"?>
# <tt xml:lang="en" xmlns="http://www.w3.org/2006/04/ttaf1"  xmlns:tts="http://www.w3.org/2006/04/ttaf1#styling">
#  <head>
#   <styling>
#      <style id="1" tts:textAlign="right"/>
#      <style id="2" tts:color="transparent"/>
#   </styling>
#  </head>
#  <body>
#   <div xml:lang="en">
#    <p begin="00:00:00.00" dur="00:00:03.07">I had just joined <span tts:fontFamily="monospaceSansSerif,proportionalSerif,TheOther"tts:fontSize="+2">Macromedia</span> in 1996,</p>
#    <p begin="00:00:03.07" dur="00:00:03.35">and we were trying to figure out what to do about the internet.</p>
#    <p begin="00:00:29.02" dur="00:00:01.30" style="1">as <span tts:color="#ccc333">easy</span> as drawing on paper.</p>
#    </div>
#  </body>
#</tt>
require 'nokogiri'

module Formats
  include PlatformEndLine

  def parse_xml
    final = []
    doc = Nokogiri::XML.parse(@raw)
    (doc/'tt'/'p').each do |line|
      time_on, time_off = ['begin', 'dur'].map { |str| line[str.to_sym] }
      text = line.inner_html
      final << Subline.new(time_on,time_off,text)
    end
    return final
  end

  def xml_lines
    endl = endline( @raw )
    line_ary = []
    @lines.each do |l|
      toff = l.time_off - l.time_on
      line_ary << "      <p begin=\"#{l.time_on}\" dur=\"#{toff}\">#{l.text}</p>"
    end
    return line_ary.join( endl )
  end

  def to_xml
    endl = endline( @raw )
    out = <<XML
<?xml version="1.0" encoding="UTF-8"?>
<tt xml:lang="en" xmlns="http://www.w3.org/2006/10/ttaf1"  xmlns:tts="http://www.w3.org/2006/10/ttaf1#styling">
  <head>
    <styling>#{@style + endl if @style}
    </styling>
  </head>
  <body>
    <div xml:lang="en">
#{xml_lines}
    </div>
  </body>
</tt>
XML
  out.chomp
  end
end
