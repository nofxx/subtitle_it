module PlatformEndLine
  def platform( raw ) 
    raw =~ /\r\n/ ? "WIN" : "UNIX"
  end
  def endline( raw )
    platform( raw ) == "WIN" ? "\r\n" : "\n"
  end
end

