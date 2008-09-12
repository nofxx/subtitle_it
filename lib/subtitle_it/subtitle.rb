require 'subtitle_it/formats/srt'
require 'subtitle_it/formats/sub'
require 'subtitle_it/formats/yml'
require 'subtitle_it/formats/rsb'
require 'subtitle_it/formats/xml'
require 'subtitle_it/formats/mpl'

module SubtitleIt
  include Formats
  
  MOVIE_EXTS = %w(3g2 3gp 3gp2 3gpp 60d ajp asf asx avchd avi bik bix box cam dat divx dmf dv dvr-ms evo flc fli flic flv flx gvi gvp h264 m1v m2p m2ts m2v m4e m4v mjp mjpeg mjpg mkv moov mov movhd movie movx mp4 mpe mpeg mpg mpv mpv2 mxf nsv nut ogg ogm omf ps qt ram rm rmvb swf ts vfw vid video viv vivo vob vro wm wmv wmx wrap wvx wx x264 xvid)
  SUB_EXTS = %w(srt sub smi txt ssa ass mpl xml yml rsb)
  
  class Subtitle    
    attr_reader :id, :raw, :format, :lines, :style, :info, :filename
    
    def initialize(dump=nil,format=nil,info=nil)
      if @info = info
        @id       = info['IDSubtitleFile'].to_i
        @filename = info['SubFileName'].to_s 
        @format   = info['SubFormat'].to_s 
      end
      @fps=23.976      
      parse_dump(dump,format) if dump
    end
    
    def parse_dump(dump,format)
      raise unless format =~ /^srt$|sub|yml|txt|rsb|xml|ass|mpl/
      @raw = dump.kind_of?(String) ? dump : dump.read
      @format = format
      parse!
    end

    def style=(s)
      @style = s
    end
    
    def fps=(fps)
      @fps = fps
    end
    
    def data=(data)
      @raw = data
    end

    private
    
    def parse!
      self.lines = send :"parse_#{@format}"      
    end
    
    def lines=(lines)
      @lines = lines
    end  
  end
end