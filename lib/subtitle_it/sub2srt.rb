module SubtitleIt
  module Sub2Srt  

    framerate = 23.976  
    infile = File.open(inn,'r')  
    outfile = File.open(out, 'w')

    read_mode = 0  
    for line in inn do |line|
      line.strip!

      if (read_mode == 0) and (string.find(line,str(subtitle_count)) >=0 )
        read_mode = 1
        next
      end

      if (read_mode == 1):
        starttime = 60*60*int(line[:2]) + 60*int(line[3:5]) + int(line[6:8]) + int(line[9:12])/1000.0
        stoptime = 60*60*int(line[17:2+17]) + 60*int(line[3+17:5+17]) + int(line[6+17:8+17]) + int(line[9+17:12+17])/1000.0
        read_mode = 2
        next
      end

      if (read_mode == 2)
        if (line == '')
          read_mode = 0
          write_str = '{%d}{%d}%s%s'%(starttime*framerate,stoptime*framerate,'|'.join(read_buffer),'\n')
          write_str = html_re.sub('',write_str)
          fout.write(write_str)
          read_buffer = []
          subtitle_count += 1
          next
        end
      end

      read_buffer += [line]
    end
  end 
end

# PYTHON CODE
# http://en.wikipedia.org/wiki/SubRip
  #  
  # fin.close()
  # fout.close()
  # import sys,string,re
  #  
  # framerate = 23.976
  #  
  # if(len(sys.argv)<2):
  #    print 'usage: %s input'%(sys.argv[0])
  #    sys.exit(0)
  #  
  # name = sys.argv[1]
  # if name[-4:] == '.srt':
  #     name = name[:-4]
  # infile = '%s.srt'%(name)
  # outfile = '%s.sub'%(name)
  #  
  # fin = open(infile,'r')
  # fout = open(outfile,'w')
  # subtitle_count = 1
  # read_mode = 0
  # read_buffer = []
  # html_re = re.compile(r'<.*?>')
  # for line in fin:
  #    line = line.strip()
  #    if (read_mode == 0) and (string.find(line,str(subtitle_count)) >=0 ):
  #       read_mode = 1
  #       continue
  #    if (read_mode == 1):
  #       starttime = 60*60*int(line[:2]) + 60*int(line[3:5]) + int(line[6:8]) + int(line[9:12])/1000.0
  #       stoptime = 60*60*int(line[17:2+17]) + 60*int(line[3+17:5+17]) + int(line[6+17:8+17]) + int(line[9+17:12+17])/1000.0
  #       read_mode = 2
  #       continue
  #    if (read_mode == 2):
  #       if (line == ''):
  #          read_mode = 0
  #          write_str = '{%d}{%d}%s%s'%(starttime*framerate,stoptime*framerate,'|'.join(read_buffer),'\n')
  #          write_str = html_re.sub('',write_str)
  #          fout.write(write_str)
  #          read_buffer = []
  #          subtitle_count += 1
  #          continue
  #       read_buffer += [line]
  #  
  # fin.close()
  # fout.close()