# MIT License
#
# Copyright (c) 2017 Sebastian Katzer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module Terminal
  class Table
    class Row

      ##
      # Row cells

      attr_reader :cells

      attr_reader :table

      ##
      # Initialize with _width_ and _options_.

      def initialize table, array = []
        @cell_index = 0
        @table = table
        @cells = []
        array.each { |item| self << item }
      end

      def add_cell item
        options = item.is_a?(Hash) ? item : {:value => item}
        cell = Cell.new(options.merge(:index => @cell_index, :table => @table))
        @cell_index += cell.colspan
        @cells << cell
      end
      alias << add_cell

      def [] index
        cells[index]
      end

      def height
        cells.map { |c| c.lines.size }.max || 0
      end

      def render
        y = @table.style.border_y
        (0...height).to_a.map do |line|
          y + cells.map do |cell|
            cell.render(line)
          end.join(y) + y
        end.join("\n")
      end

      def number_of_columns
        @cells.collect(&:colspan).inject(0, &:+)
      end
    end
  end
end
