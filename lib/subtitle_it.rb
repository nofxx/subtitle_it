$LOAD_PATH.unshift(File.dirname(__FILE__)) unless
$LOAD_PATH.include?(File.dirname(__FILE__)) || $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
require 'yaml'

require 'subtitle_it/version'
require 'subtitle_it/languages'
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
    self / 10**Math.log10(self).to_i
  end
end

if RUBY_PLATFORM >= '1.9'
  class String
    def to_a
      lines.to_a
    end
  end
end
