# mruby-terminal-table

A fast and simple, yet feature rich ASCII table generator for mruby based on [terminal-table][terminal-table].

## Installation

Add the line below to your `build_config.rb`:

```ruby
conf.gem github: 'appplant/mruby-terminal-table'
```

## Usage

To generate a table, provide an array of rows:

```ruby
rows  = [ ['One', 1], ['Two', 2], ['Three', 3] ]

table = Terminal::Table.new rows: rows

# > puts table
#
# +-------+---+
# | One   | 1 |
# | Two   | 2 |
# | Three | 3 |
# +-------+---+
```

The constructor can also be given a block which is either yielded the Table object or instance evaluated:

```ruby
table = Terminal::Table.new do |t|
  t.rows = rows
end

table = Terminal::Table.new do
  self.rows = rows
end
```

Adding rows one by one:

```ruby
table = Terminal::Table.new do |t|
  t << ['One', 1]
  t.add_row ['Two', 2]
end
```

To add separators between rows:

```ruby
table = Terminal::Table.new do |t|
  t << ['One', 1]
  t << :separator
  t.add_row ['Two', 2]
  t.add_separator
  t.add_row ['Three', 3]
end

# > puts table
#
# +-------+---+
# | One   | 1 |
# +-------+---+
# | Two   | 2 |
# +-------+---+
# | Three | 3 |
# +-------+---+
```

Cells can handle multiline content:

```ruby
table = Terminal::Table.new do |t|
  t << ['One', 1]
  t << :separator
  t.add_row ["Two\nDouble", 2]
  t.add_separator
  t.add_row ['Three', 3]
end

# > puts table
#
# +--------+---+
# | One    | 1 |
# +--------+---+
# | Two    | 2 |
# | Double |   |
# +--------+---+
# | Three  | 3 |
# +--------+---+
```

### Headings

To add a head to the table:

```ruby
table = Terminal::Table.new headings: ['Word', 'Number'], rows: rows

# > puts table
#
# +-------+--------+
# | Word  | Number |
# +-------+--------+
# | One   | 1      |
# | Two   | 2      |
# | Three | 3      |
# +-------+--------+
```

To add a title to the table:

```ruby
table = Terminal::Table.new title: 'Cheatsheet', headings: ['Word', 'Number'], rows: rows

# > puts table
#
# +------------+--------+
# |     Cheatsheet      |
# +------------+--------+
# | Word       | Number |
# +------------+--------+
# | One        | 1      |
# | Two        | 2      |
# | Three      | 3      |
# +------------+--------+
```

### Alignment

To align the second column to the right:

```ruby
table.align_column 1, :right

# > puts table
#
# +-------+--------+
# | Word  | Number |
# +-------+--------+
# | One   |      1 |
# | Two   |      2 |
# | Three |      3 |
# +-------+--------+
```

To align an individual cell, you specify the cell value in a hash along the alignment:

```ruby
table << ['Four', value: 4.0, alignment: :center]

# > puts table
#
# +-------+--------+
# | Word  | Number |
# +-------+--------+
# | One   |      1 |
# | Two   |      2 |
# | Three |      3 |
# | Four  |  4.0   |
# +-------+--------+
```

### Custom styles

To specify style options:

```ruby
table = Terminal::Table.new headings: ['Word', 'Number'], rows: rows, style: { width: 80 }

# > puts table
#
# +--------------------------------------+---------------------------------------+
# | Word                                 | Number                                |
# +--------------------------------------+---------------------------------------+
# | One                                  | 1                                     |
# | Two                                  | 2                                     |
# | Three                                | 3                                     |
# +--------------------------------------+---------------------------------------+
```

And change styles on the fly:

```ruby
table.style = { width: 40, padding_left: 3, border_x: '=', border_i: 'x' }

# > puts table
#
# x====================x=================x
# |               Cheatsheet             |
# x====================x=================x
# |   Word             |   Number        |
# x====================x=================x
# |   One              |   1             |
# |   Two              |   2             |
# |   Three            |   3             |
# x====================x=================x
```

You can also use styles to add a separator after every row:

```ruby
table = Terminal::Table.new do |t|
  t.add_row [1, 'One']
  t.add_row [2, 'Two']
  t.add_row [3, 'Three']
  t.style = { all_separators: true }
end

# > puts table
#
# +---+-------+
# | 1 | One   |
# +---+-------+
# | 2 | Two   |
# +---+-------+
# | 3 | Three |
# +---+-------+
```

To change the default style options:

```ruby
Terminal::Table::Style.defaults = { width: 80 }
```

All Table objects created afterwards will inherit these defaults.

### Constructor and setters

Valid options for the constructor are `rows`, `headings`, `style` and `title` - and all options can also be set on the created table object by their setter method:

```ruby
table = Terminal::Table.new

table.title    = 'Cheatsheet'
table.headings = ['Word', 'Number']
table.rows     = rows
table.style    = { width: 40 }
```

## License

The gem is available as open source under the terms of the [MIT License][license].

Made with :yum: from Leipzig

© 2017 [appPlant GmbH][appplant]

[terminal-table]: https://github.com/tj/terminal-table
[license]: http://opensource.org/licenses/MIT
[appplant]: www.appplant.de
