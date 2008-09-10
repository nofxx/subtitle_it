# downsub - github.com/johanlunds/downsub
require 'subtitle_it/movie_hasher'

module SubtitleIt
  class Movie
    EXTS = %w(3g2 3gp 3gp2 3gpp 60d ajp asf asx avchd avi bik bix box cam dat divx dmf dv dvr-ms evo flc fli flic flv flx gvi gvp h264 m1v m2p m2ts m2v m4e m4v mjp mjpeg mjpg mkv moov mov movhd movie movx mp4 mpe mpeg mpg mpv mpv2 mxf nsv nut ogg ogm omf ps qt ram rm rmvb swf ts vfw vid video viv vivo vob vro wm wmv wmx wrap wvx wx x264 xvid)

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