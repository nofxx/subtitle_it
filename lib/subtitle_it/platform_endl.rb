module PlatformEndLine
  def platform(raw)
    raw =~ /\r\n/ ? 'WIN' : 'UNIX'
  rescue ArgumentError => e
    'WIN'
  end

  def endline(raw)
    platform(raw) == 'WIN' ? "\r\n" : "\n"
  end
end
