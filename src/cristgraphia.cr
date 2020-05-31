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
end

o = Celestine.draw do |ctx|
  ctx.view_box = {x: 0, y: 0, w: 100, h: 100}
  # draw a circle
  ctx.circle do |circle|
    # We are now configuring the circle
    circle.x = 10
    circle.y = 20
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

include Cristgraphia

puts cister("OK alors c'est super les gars...")
