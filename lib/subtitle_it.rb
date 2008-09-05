$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# require 'yaml'
# require 'subtitle_it/delay'
# require 'subtitle_it/subtitle'
# require 'subtitle_it/subline'
# require 'subtitle_it/formats/srt'
# require 'subtitle_it/formats/sub'
# require 'subtitle_it/formats/yml'
# require 'subtitle_it/formats/pseudo'

module SubtitleIt
  include Delay

end
