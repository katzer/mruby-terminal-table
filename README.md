# mruby-terminal-table [![Build Status](https://travis-ci.org/appPlant/mruby-terminal-table.svg?branch=master)](https://travis-ci.org/appPlant/mruby-terminal-table) [![Build status](https://ci.appveyor.com/api/projects/status/qk46hmx7d6nn6eon/branch/master?svg=true)](https://ci.appveyor.com/project/katzer/mruby-terminal-table/branch/master)

A fast and simple, yet feature rich ASCII table generator for mruby based on [terminal-table][terminal-table].

## Installation

Add the line below to your `build_config.rb`:

```ruby
MRuby::Build.new do |conf|
  # ... (snip) ...
  conf.gem 'mruby-terminal-table'
end
```

Or add this line to your aplication's `mrbgem.rake`:

```ruby
MRuby::Gem::Specification.new('your-mrbgem') do |spec|
  # ... (snap) ...
  spec.add_dependency 'mruby-terminal-table'
end
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
table = Terminal::Table.new headings: %w(Word Number), rows: rows

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
table = Terminal::Table.new title: 'Cheatsheet', headings: %w(Word Number), rows: rows

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
table = Terminal::Table.new headings: %w(Word Number), rows: rows, style: { width: 80 }

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
table.headings = %w(Word Number)
table.rows     = rows
table.style    = { width: 40 }
```

## Development

Clone the repo:
    
    $ git clone https://github.com/appplant/mruby-terminal-table.git && cd mruby-terminal-table/

Compile the source:

    $ rake compile

Run the tests:

    $ rake test

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/appplant/mruby-terminal-table.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

- All contributors from the [terminal-table][terminal-table] gem.
- Sebastián Katzer, Fa. appPlant GmbH


## License

The gem is available as open source under the terms of the [MIT License][license].

Made with :yum: from Leipzig

© 2017 [appPlant GmbH][appplant]

[terminal-table]: https://github.com/tj/terminal-table
[license]: http://opensource.org/licenses/MIT
[appplant]: www.appplant.de
