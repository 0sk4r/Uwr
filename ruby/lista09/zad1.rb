require 'tk'

class Fractals
  def initialize
    @deg_to_rad = Math::PI / 180.0

    @win = TkRoot.new { title 'Fraktale'}
    @win['geometry'] = '1000x1000'
    @canvas = TkCanvas.new(@win) {pack}
    @height = 1000
    @width = 1000
    @canvas.place(:height => @height, :width => @width)
    @entry = TkEntry.new(@win) {pack}
    @button = TkButton.new(@win) {text 'Display Sierpinski'; pack}
    @button.command { self.displaySierpinski }
    @button1 = TkButton.new(@win) {text 'Display Pythagoras '; pack}
    @button1.command { self.displayPythagoras }

    Tk.mainloop
  end

  def displaySierpinski
    @canvas.delete('all')
    p1 = [@width/2, 10]
    p2 = [10, @height-10]
    p3 = [@width-10, @height-10]
    self.display_triangles(eval(@entry.value).to_i, p1, p2, p3)
  end
  def displayPythagoras
    @canvas.delete('all')
    self.drawTree(500, 1000, -90, eval(@entry.value).to_i)
  end

  def display_triangles(order, p1, p2, p3)
    if order == 0
      @canvas.create(TkcLine, p1, p2)
      @canvas.create(TkcLine, p2, p3)
      @canvas.create(TkcLine, p3, p1)
    else
      p12 = self.midpoint(p1, p2)
      p23 = self.midpoint(p2, p3)
      p13 = self.midpoint(p1, p3)

      self.display_triangles(order-1, p1, p12, p13)
      self.display_triangles(order-1, p12, p2, p23)
      self.display_triangles(order-1, p13, p23, p3)
    end
  end

  def midpoint(p1, p2)
    p = []
    p[0] = (p1[0] + p2[0]) / 2
    p[1] = (p1[1] + p2[1]) / 2
    return p
  end

  def drawTree(x1, y1, angle, depth)
    if depth != 0
      x2 = x1 + (Math.cos(angle * @deg_to_rad) * depth * 10).to_i
      y2 = y1 + (Math.sin(angle * @deg_to_rad) * depth * 10).to_i
      @canvas.create(TkcLine, [x1, y1], [x2, y2])
      #line x1, y1, x2, y2

      drawTree(x2, y2, angle - 20, depth - 1)
      drawTree(x2, y2, angle + 20, depth - 1)
    end
  end
end

Fractals.new.run