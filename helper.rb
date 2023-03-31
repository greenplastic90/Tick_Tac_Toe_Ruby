module Helper
  def typewriter(string, speed)
    string.chars.each do |char|
      print char
      sleep speed
    end
    puts ''
  end

  def colorize(text, color)
    color_codes = {
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      magenta: 35,
      cyan: 36
    }

    "\e[#{color_codes[color]}m#{text}\e[0m"
  end
end
