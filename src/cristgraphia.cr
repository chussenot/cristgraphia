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
content = Celestine.draw do |ctx|
  ctx.view_box = {x: 0, y: 0, w: 100 * sequence.size, h: 100 * sequence.size}
  # draw a circle
  sequence.map { |s| digits(s) }
  .each_slice(Math.sqrt(sequence.size).to_i) do |slice|
    y += SPACE + 100
    slice.each_with_index do |s, i| 
      x = (100 + SPACE) * i
      # symbol(s, i, y) 
      ctx.circle do |circle|
        # We are now configuring the circle
        circle.x = x
        circle.y = y
        circle.stroke = "black"
        circle.fill = "none"
        circle.radius = 10
        # Want to specify in css units? Try these handy patch methods
        circle.radius = 10.px
        circle.x = 10.percent
        circle.y = 10.vmax
        circle
      end
    end
  end

end

# End

path = "inline.svg"
File.write(path, content)