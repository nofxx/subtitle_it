module SubtitleIt
  module V #:nodoc:
    MAJOR = 0
    MINOR = 5
    TINY  = 5

    STRING = [MAJOR, MINOR, TINY].join('.')
  end
  def version
    STRING
  end
end
