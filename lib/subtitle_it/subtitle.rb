require 'subtitle_it/formats/srt'
require 'subtitle_it/formats/sub'
require 'subtitle_it/formats/yml'
require 'subtitle_it/formats/rsb'
require 'subtitle_it/formats/xml'
require 'subtitle_it/formats/mpl'

# http://en.wikipedia.org/wiki/List_of_ISO_639-2_codes
# http://www.opensubtitles.org/addons/export_languages.php

module SubtitleIt
  MOVIE_EXTS = %w(3g2 3gp 3gp2 3gpp 60d ajp asf asx avchd avi bik bix box cam
                  dat divx dmf dv dvr-ms evo flc fli flic flv flx gvi gvp h264
                  m1v m2p m2ts m2v m4e m4v mjp mjpeg mjpg mkv moov mov movhd
                  movie movx mp4 mpe mpeg mpg mpv mpv2 mxf nsv nut ogg ogm omf
                  ps qt ram rm rmvb swf ts vfw vid video viv vivo vob vro wm
                  wmv wmx wrap wvx wx x264 xvid).freeze

  SUB_EXTS = %w(srt sub smi txt ssa ass mpl xml yml rsb).freeze

  #
  # Le Subtitle pour le Movie
  #
  class Subtitle
    include Comparable
    include Formats

    attr_reader :id, :raw, :format, :lines, :style, :info, :filename, :rating,
                :language, :user, :release_name, :osdb_id, :original_filename,
                :download_count, :download_url

    attr_writer :style, :lines, :fps

    def initialize(args = {})
      # Looks like opensubtitle is the only provider around..
      # If a second one comes need big refactor...
      if (@info = args[:info])
        # @osdb_info         = info
        @osdb_id           = @info['IDSubtitleFile'].to_s
        @original_filename = @info['SubFileName'].to_s
        @format            = @info['SubFormat'].to_s
        @user              = @info['UserNickName'].to_s
        @language          = @info['LanguageName'].to_s
        @release_name      = @info['MovieReleaseName'].to_s
        @download_count    = @info['SubDownloadsCnt'].to_i
        @rating            = @info['SubRating'].to_f
        @uploaded_at       = @info['SubAddDate'].to_s # TODO: convert to Date?
        @download_url      = @info['SubDownloadLink'].to_s
      end
      @fps = args[:fps] || 23.976
      return unless args[:dump]
      parse_dump(args[:dump], args[:format])
    end

    def data=(data)
      @raw = data
    end

    def <=>(other)
      rating <=> other.rating
    end

    private

    # Force subtitles to be UTF-8
    def encode_dump(dump)
      dump = dump.read unless dump.is_a?(String)

      enc = CharlockHolmes::EncodingDetector.detect(dump)
      if enc[:encoding] != 'UTF-8'
        puts "Converting `#{enc[:encoding]}` to `UTF-8`".yellow
        dump = CharlockHolmes::Converter.convert dump, enc[:encoding], 'UTF-8'
      end
      dump
    end

    def parse_dump(dump, format)
      raise unless SUB_EXTS.include?(format)
      @raw = encode_dump(dump)
      @format = format
      parse_lines!
    end

    def parse_lines!
      self.lines = send :"parse_#{@format}"
    end
  end
end
