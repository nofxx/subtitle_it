$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'

require 'subtitle_it/delay'
require 'subtitle_it/subtime'
require 'subtitle_it/subline'
require 'subtitle_it/subtitle'

module SubtitleIt
end

class Numeric
  def reduce
    self / ( 10 ** Math::log10(self).to_i)
  end
end