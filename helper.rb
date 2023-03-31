module Helper
  def typewriter(string, speed)
    string.chars.each do |char|
      print char
      sleep speed
    end
    puts ''
  end
end
