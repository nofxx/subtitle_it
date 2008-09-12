# downsub - github.com/johanlunds/downsub
require 'subtitle_it/movie_hasher'

module SubtitleIt
  class Movie

    attr_reader :filename
    attr_accessor :info

    def initialize(filename)
      @filename = filename
      @haxx = nil
      @info = {}
    end

    def haxx
      @haxx ||= MovieHasher::compute_haxx(@filename)
    end

    def size
      File.size(@filename)
    end
  end
end