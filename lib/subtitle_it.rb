$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'rubygems'
require 'subtitle_it/version'
require 'subtitle_it/subtime'
require 'subtitle_it/subline'
require 'subtitle_it/platform_endl'
require 'subtitle_it/subtitle'
require 'subtitle_it/subdown'
require 'subtitle_it/substyle'
require 'subtitle_it/movie'
require 'subtitle_it/bin'

module SubtitleIt
end

class Numeric
  def reduce
    self / ( 10 ** Math::log10(self).to_i)
  end
end
