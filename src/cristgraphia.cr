require "celestine"

module Cristgraphia
  VERSION = "0.1.0"
  SPACE   = 20
  TABLET  = {
    'a' => 1,
    'b' => 2,
    'c' => 3,
    'd' => 4,
    'e' => 5,
    'f' => 6,
    'g' => 7,
    'h' => 8,
    'i' => 9,
    'j' => 10,
    'k' => 11,
    'l' => 12,
    'm' => 13,
    'n' => 14,
    'o' => 15,
    'p' => 16,
    'q' => 18,
    'r' => 19,
    's' => 100,
    't' => 200,
    'u' => 300,
    'v' => 400,
    'w' => 500,
    'x' => 600,
    'y' => 700,
    'z' => 800,
    ' ' => 900,
  }

  # Clean the given string for something...
  # that we can handle.
  def cister(message)
    message.downcase
      .gsub(/\W/, ' ')
      .squeeze(' ')
      .strip
      .chars
      .map do |c|
        n = TABLET[c] * 10
        r = rand(n)
        [n - r, r].shuffle
      end.flatten
  end

  # Extract units, tens, thousands, hundreds
  def digits(num)
    cs = num.to_s.chars
    ([] of Int32).tap do |o|
      while cs.size > 0
        c = cs.shift
        o << (c + Array.new(cs.size) { |_i| 0 }.join).to_i
      end
    end
  end

  # Is it a perfect square?
  def perfect_square?(x)
    Math.sqrt(x) % 1 == 0
  end

  # Insert at random place symbols.
  # Every symbol before the 9999 symbol
  # (should be ignored to uncipher the message...)
  def inject_evil_symbols(array)
    index = rand(0..array.size)
    array.insert(index, 9999)
    array.insert(index, rand(9999))
  end

  def draw(plan, sign_values, x, y)
    plan.rectangle do |rect|
      # We are now placing a red square
      # to draw the sign.
      rect.x = x
      rect.y = y
      rect.width = 100.px
      rect.height = 100.px
      rect.stroke = "red"
      rect.fill = "none"
      rect
    end
    # Line that always appear
    plan.rectangle do |rect|
      # We are now configuring the line
      rect.x = x
      rect.y = y
      rect.width = 2.px
      rect.height = 100.px
      rect.stroke = "black"
      rect.fill = "black"
      # Use transform methods
      rect.transform do |t|
        t.translate(50, 0)
        t
      end
      rect
    end

    # Lines that may or may not appear depending of the digit
    sign_values.each do |num|
      case num
      when 1
        ##line(50, 0, 100, 0).translate(x, y) # 1579 -
      when 2
        ##line(50, 50, 100, 50).translate(x, y) # 289 _
      when 3
        ##line(50, 0, 100, 50).translate(x, y) # 3 \
      when 4
        #line(50, 50, 100, 0).translate(x, y) # 45 /
      when 5
        #line(50, 0, 100, 0).translate(x, y)  # 1579 -
        #line(50, 50, 100, 0).translate(x, y) # 45 /
      when 6
        #line(100, 0, 100, 50).translate(x, y) # 6789 |
      when 7
        #line(50, 0, 100, 0).translate(x, y)   # 1579 -
        #line(100, 0, 100, 50).translate(x, y) # 6789 |
      when 8
        #line(100, 0, 100, 50).translate(x, y) # 6789 |
        #line(50, 50, 100, 50).translate(x, y) # 289 _
      when 9
        #line(50, 0, 100, 0).translate(x, y)   # 1579 -
        #line(100, 0, 100, 50).translate(x, y) # 6789 |
        #line(50, 50, 100, 50).translate(x, y) # 289 _
      when 10
        #line(50, 0, 0, 0).translate(x, y) # 1579 -
      when 20
        #line(50, 50, 0, 50).translate(x, y) # 289 _
      when 30
        #line(50, 0, 0, 50).translate(x, y) # 3 /
      when 40
        #line(50, 50, 0, 0).translate(x, y) # 45 \
      when 50
        #line(50, 50, 0, 0).translate(x, y) # 45 \
        #line(50, 0, 0, 0).translate(x, y)  # 1579 -
      when 60
        #line(0, 50, 0, 0).translate(x, y) # 6789 |
      when 70
        #line(0, 50, 0, 0).translate(x, y) # 6789 |
        #line(50, 0, 0, 0).translate(x, y) # 1579 -
      when 80
        #line(50, 50, 0, 50).translate(x, y) # 289 _
        #line(0, 50, 0, 0).translate(x, y)   # 6789 |
      when 90
        #line(0, 50, 0, 0).translate(x, y)   # 6789 |
        #line(50, 0, 0, 0).translate(x, y)   # 1579 -
        #line(50, 50, 0, 50).translate(x, y) # 289 _
      when 100
        #line(50, 100, 100, 100).translate(x, y) # 1579 _
      when 200
        #line(50, 50, 100, 50).translate(x, y) # 289 -
      when 300
        #line(50, 100, 100, 50).translate(x, y) # 3 /
      when 400
        #line(50, 50, 100, 100).translate(x, y) # 45 \
      when 500
        #line(50, 50, 100, 100).translate(x, y)  # 45 \
        #line(50, 100, 100, 100).translate(x, y) # 1579 _
      when 600
        #line(100, 50, 100, 100).translate(x, y) # 6789 |
      when 700
        #line(100, 50, 100, 100).translate(x, y) # 6789 |
        #line(50, 100, 100, 100).translate(x, y) # 1579 _
      when 800
        #line(100, 50, 100, 100).translate(x, y) # 6789 |
        #line(50, 50, 100, 50).translate(x, y)   # 289 -
      when 900
        #line(100, 50, 100, 100).translate(x, y) # 6789 |
        #line(50, 100, 100, 100).translate(x, y) # 1579 _
        #line(50, 50, 100, 50).translate(x, y)   # 289 -
      when 1000
        #line(50, 100, 0, 100).translate(x, y) # 1579 _
      when 2000
        #line(50, 50, 0, 50).translate(x, y) # 289 -
      when 3000
        #line(50, 100, 0, 50).translate(x, y) # 3 \
      when 4000
        #line(50, 50, 0, 100).translate(x, y) # 45 /
      when 5000
        #line(50, 50, 0, 100).translate(x, y)  # 45 /
        #line(50, 100, 0, 100).translate(x, y) # 1579 _
      when 6000
        #line(0, 50, 0, 100).translate(x, y) # 6789 |
      when 7000
        #line(50, 100, 0, 100).translate(x, y) # 1579 _
        #line(0, 50, 0, 100).translate(x, y)   # 6789 |
      when 8000
        #line(0, 50, 0, 100).translate(x, y) # 6789 |
        #line(50, 50, 0, 50).translate(x, y) # 289 -
      when 9000
        #line(0, 50, 0, 100).translate(x, y)   # 6789 |
        #line(50, 100, 0, 100).translate(x, y) # 1579 _
        #line(50, 50, 0, 50).translate(x, y)   # 289 -
      end
    end
  end
end

include Cristgraphia

# Begin Prepare a perfect square
sequence = cister("OK alors c'est super les gars...")
until perfect_square?(sequence.size)
  sequence = inject_evil_symbols(sequence)
end
# End

# Begin Draw line by line
y = 0
content = Celestine.draw do |plan|
  plan.view_box = {x: 0, y: 0, w: SPACE * sequence.size, h: SPACE * sequence.size}
  # draw a circle
  sequence.map { |s| digits(s) }
    .each_slice(Math.sqrt(sequence.size).to_i) do |slice|
      y += SPACE + 100
      slice.each_with_index do |sign_values, index|
        x = (100 + SPACE) * index
        draw(plan, sign_values, x, y)
      end
    end
end
# End

path = "inline.svg"
File.write(path, content)
