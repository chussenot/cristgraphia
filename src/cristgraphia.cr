require "celestine"

module Cristgraphia
  VERSION = "0.2.0"
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
    # Draw the bounds
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
    end if false

    # Line that always appear
    plan.path do |path|
      path.r_move(50, 0)
      path.a_line(50, 100)
      path.stroke = "black"
      # Use transform methods
      path.transform do |t|
        t.translate(x, y)
        t
      end
      path
    end

    # Lines that may or may not appear depending of the digits.
    # example <path d="m50,0L100,0" stroke="green" transform="translate(720,960)" />
    # https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths
    sign_values.each do |num|
      plan.path do |path|
        path.stroke = "black"
        # Use transform methods
        path.transform do |t|
          t.translate(x, y)
          t
        end
        case num
        when 1
          path.a_move(50, 0)
          path.a_line(100, 0)
          # 1579 -
        when 2
          path.a_move(50, 50)
          path.a_line(100, 50)
          # 289 _
        when 3
          # #line(50, 0, 100, 50).translate(x, y)
          path.a_move(50, 0)
          path.a_line(100, 50)
          # 3 \
        when 4
          # line(50, 50, 100, 0).translate(x, y)
          path.a_move(50, 50)
          path.a_line(100, 0)
          # 45 /
        when 5
          path.a_move(50, 0)
          path.a_line(100, 0)
          # 1579 -
          path.a_move(50, 50)
          path.a_line(100, 0)
          # 45 /
        when 6
          path.a_move(100, 0)
          path.a_line(100, 50)
          # 6789 |
        when 7
          path.a_move(50, 0)
          path.a_line(100, 0)
          # 1579 -
          path.a_move(100, 0)
          path.a_line(100, 50)
          # 6789 |
        when 8
          path.a_move(100, 0)
          path.a_line(100, 50)
          # 6789 |
          path.a_move(50, 50)
          path.a_line(100, 50)
          # 289 _
        when 9
          path.a_move(50, 0)
          path.a_line(100, 0)
          # 1579 -
          path.a_move(100, 0)
          path.a_line(100, 50)
          # 6789 |
          path.a_move(50, 50)
          path.a_line(100, 50)
          # 289 _
        when 10
          path.a_move(50, 0)
          path.a_line(0, 0)
          # 1579 -
        when 20
          path.a_move(50, 50)
          path.a_line(0, 50)
          # 289 _
        when 30
          path.a_move(50, 0)
          path.a_line(0, 50)
          # 3 /
        when 40
          path.a_move(50, 50)
          path.a_line(0, 0)
          # 45 \
        when 50
          path.a_move(50, 50)
          path.a_line(0, 0)
          # 45 \
          path.a_move(50, 0)
          path.a_line(0, 0)
          # 1579 -
        when 60
          path.a_move(0, 50)
          path.a_line(0, 0)
          # 6789 |
        when 70
          path.a_move(0, 50)
          path.a_line(0, 0)
          # 6789 |
          path.a_move(50, 0)
          path.a_line(0, 0)
          # 1579 -
        when 80
          path.a_move(50, 50)
          path.a_line(0, 50)
          # 289 _
          path.a_move(0, 50)
          path.a_line(0, 0)
          # 6789 |
        when 90
          path.a_move(0, 50)
          path.a_line(0, 0)
          # 6789 |
          path.a_move(50, 0)
          path.a_line(0, 0)
          # 1579 -
          path.a_move(50, 50)
          path.a_line(0, 50)
          # 289 _
        when 100
          path.a_move(50, 100)
          path.a_line(100, 100)
          # 1579 _
        when 200
          path.a_move(50, 50)
          path.a_line(100, 50)
          # 289 -
        when 300
          path.a_move(50, 100)
          path.a_line(100, 50)
          # 3 /
        when 400
          path.a_move(50, 50)
          path.a_line(100, 100)
          # 45 \
        when 500
          path.a_move(50, 50)
          path.a_line(100, 100)
          # 45 \
          path.a_move(50, 100)
          path.a_line(100, 100)
          # 1579 _
        when 600
          path.a_move(100, 50)
          path.a_line(100, 100)
          # 6789 |
        when 700
          path.a_move(100, 50)
          path.a_line(100, 100)
          # 6789 |
          path.a_move(50, 100)
          path.a_line(100, 100)
          # 1579 _
        when 800
          path.a_move(100, 50)
          path.a_line(100, 100)
          # 6789 |
          path.a_move(50, 50)
          path.a_line(100, 50)
          # 289 -
        when 900
          path.a_move(100, 50)
          path.a_line(100, 100)
          # 6789 |
          path.a_move(50, 100)
          path.a_line(100, 100)
          # 1579 _
          path.a_move(50, 50)
          path.a_line(100, 50)
          # 289 -
        when 1000
          path.a_move(50, 100)
          path.a_line(0, 100)
          # 1579 _
        when 2000
          path.a_move(50, 50)
          path.a_line(0, 50)
          # 289 -
        when 3000
          path.a_move(50, 100)
          path.a_line(0, 50)
          # 3 \
        when 4000
          path.a_move(50, 50)
          path.a_line(0, 100)
          # 45 /
        when 5000
          path.a_move(50, 50)
          path.a_line(0, 100)
          # 45 /
          path.a_move(50, 100)
          path.a_line(0, 100)
          # 1579 _
        when 6000
          path.a_move(0, 50)
          path.a_line(0, 100)
          # 6789 |
        when 7000
          path.a_move(50, 100)
          path.a_line(0, 100)
          # 1579 _
          path.a_move(50, 0)
          path.a_line(0, 100)
          # 6789 |
        when 8000
          path.a_move(0, 50)
          path.a_line(0, 100)
          # 6789 |
          path.a_move(50, 50)
          path.a_line(0, 50)
          # 289 -
        when 9000
          path.a_move(0, 50)
          path.a_line(0, 100)
          # 6789 |
          path.a_move(50, 100)
          path.a_line(0, 100)
          # 1579 _
          path.a_move(50, 50)
          path.a_line(0, 50)
          # 289 -
        end
        path
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

#path = "inline.svg"
#File.write(path, content)
puts content