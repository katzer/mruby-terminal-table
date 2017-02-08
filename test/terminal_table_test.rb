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

rows  = [['One', 1], ['Two', 2], ['Three', 3]]
table = nil

assert 'simple table' do
  assert_nothing_raised { table = Terminal::Table.new(rows: rows) }
  lines = table.to_s.split("\n")
  assert_equal lines.size, 5
  assert_equal lines[1].length, 13
end

assert 'code block' do
  table = Terminal::Table.new { |t| t.rows = rows }
  assert_equal table.rows.size, rows.size
end

assert 'add rows' do
  table = Terminal::Table.new do |t|
    t << ['One', 1]
    t.add_row ['Two', 2]
  end
  assert_equal table.rows.size, 2
end

assert 'add separator' do
  table = Terminal::Table.new do |t|
    t << ['One', 1]
    t << :separator
    t.add_row ['Two', 2]
    t.add_separator
    t.add_row ['Three', 3]
  end
  lines = table.to_s.split("\n")
  assert_equal lines.size, 7
  assert_include lines, '+-------+---+'
end

assert 'multiline content' do
  table = Terminal::Table.new do |t|
    t << ['One', 1]
    t << :separator
    t.add_row ["Two\nDouble", 2]
    t.add_separator
    t.add_row ['Three', 3]
  end
  lines = table.to_s.split("\n")
  assert_equal lines.size, 8
  assert_include lines, '| Two    | 2 |'
  assert_include lines, '| Double |   |'
end

assert 'headings' do
  table = Terminal::Table.new headings: %w(Word Number), rows: rows
  lines = table.to_s.split("\n")
  assert_equal lines.size, 7
  assert_include lines, '| Word  | Number |'
end

assert 'title' do
  table = Terminal::Table.new title: 'Cheatsheet', headings: %w(Word Number), rows: rows
  lines = table.to_s.split("\n")
  assert_equal lines.size, 9
  assert_include lines, '|   Cheatsheet   |'
end

assert 'alignment' do
  table = Terminal::Table.new headings: %w(Word Number), rows: rows
  table.align_column 1, :right
  table << ['Four', value: 4.01, alignment: :center]
  lines = table.to_s.split("\n")
  assert_equal lines.size, 8
  assert_include lines, '| Three |      3 |'
  assert_include lines, '| Four  |  4.01  |'
end

assert 'width' do
  table = Terminal::Table.new rows: rows, style: { width: 80 }
  lines = table.to_s.split("\n")
  assert_equal lines[1].length, 80
end

assert 'styles' do
  table = Terminal::Table.new rows: rows
  table.style = { width: 40, padding_left: 3, border_x: '=', border_i: 'x' }
  lines = table.to_s.split("\n")
  assert_include lines, 'x===================x==================x'
end

assert 'all seperators' do
  table = Terminal::Table.new do |t|
    t.add_row [1, 'One']
    t.add_row [2, 'Two']
    t.add_row [3, 'Three']
    t.style = { all_separators: true }
  end
  lines = table.to_s.split("\n")
  assert_equal lines.size, 7
end
