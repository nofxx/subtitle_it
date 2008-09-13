## downsub - github.com/johanlunds/downsub
require 'xmlrpc/client'
require 'zlib'
require 'stringio'

require 'subtitle_it/version'
require 'subtitle_it/subtitle'

module SubtitleIt
  class Subdown
    HOST = "http://www.opensubtitles.org/xml-rpc"
    HOST_DEV = "http://dev.opensubtitles.org/xml-rpc"

    USER_AGENT = "SubtitleIt #{SubtitleIt::VERSION::STRING}"

    NO_TOKEN = %w(ServerInfo LogIn)

    def initialize(host = HOST)
      @client = XMLRPC::Client.new2(host)
      @token = nil
    end

    def log_in!
      result = call('LogIn', '', '', '', USER_AGENT)
      @token = result['token'].to_s
    end

    def logged_in?
      !@token.nil? && !@token.empty?
    end

    def log_out!
      call('LogOut')
      @token = nil
    end

    def server_info
      call('ServerInfo')
    end

    def search_subtitles(movie)
      args = {
        'sublanguageid' => '',
        'moviehash'     => movie.haxx,
        'moviebytesize' => movie.size
      }

      result = call('SearchSubtitles', [args])
      return [] unless result['data'] # if no results result['data'] == false
      result['data'].inject([]) do |subs, sub_info|
        subs << Subtitle.new({:info => sub_info})
        subs
      end
    end

    def download_subtitle(sub)
      result = call('DownloadSubtitles', [sub.id])
      sub.data = self.class.decode_and_unzip(result['data'][0]['data'])     
    end

    def upload_subtitle(movie, subs)
    end

    def imdb_info(movie)
      result = call('CheckMovieHash', [movie.haxx])
      movie.info = result['data'][movie.haxx] # TODO: Handle if no result for movie
    end

    def subtitle_languages
    end

    private

      def call(method, *args)
        unless NO_TOKEN.include? method
          raise 'Need to be logged in for this.' unless logged_in?
          args = [@token, *args]
        end

        result = @client.call(method, *args)
#        $LOG.debug "Client#call #{method}, #{args.inspect}: #{result.inspect}"
        
        if result['status'] && !((200...300) === result['status'].to_i)
          raise 'Status not OK in result.'
        end
        
        result
      end

      def prevent_session_expiration
        call('NoOperation')
      end

      def self.decode_and_unzip(data)
        Zlib::GzipReader.new(StringIO.new(XMLRPC::Base64.decode(data))).read
      end
  end
end