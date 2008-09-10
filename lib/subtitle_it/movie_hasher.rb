# downsub - github.com/johanlunds/downsub
module SubtitleIt
  module MovieHasher

    CHUNK_SIZE = 64 * 1024 # in bytes

    def self.compute_haxx(filename)
      filesize = File.size(filename)
      haxx = filesize

      # Read 64 kbytes, divide up into 64 bits and add each
      # to hash. Do for beginning and end of file.
      File.open(filename, 'rb') do |f|    
        # Q = unsigned long long = 64 bit
        f.read(CHUNK_SIZE).unpack("Q*").each do |n|
          haxx = haxx + n & 0xffffffffffffffff # to remain as 64 bit number
        end

        f.seek([0, filesize - CHUNK_SIZE].max, IO::SEEK_SET)

        # And again for the end of the file
        f.read(CHUNK_SIZE).unpack("Q*").each do |n|
          haxx = haxx + n & 0xffffffffffffffff
        end
      end

      sprintf("%016x", haxx)
    end
  end
end