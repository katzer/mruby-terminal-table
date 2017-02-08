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

class String
  unless respond_to? :rjust
    def rjust(width, padstr = ' ')
      return to_s unless width > length
      reverse.ljust(width, padstr).reverse!
    end
  end

  unless respond_to? :center
    def center(width, padstr = ' ')
      return to_s unless width > length
      padlen = (width - length).divmod(2)[0]
      ljust(length + padlen, padstr).rjust(width, padstr)
    end
  end
end

unless Symbol.respond_to? :to_proc
  class Symbol
    def to_proc
      ->(obj, *args, &block) { obj.__send__(self, *args, &block) }
    end
  end
end

unless Hash.respond_to? :fetch
  class Hash
    def fetch(key, default = nil)
      key?(key) ? self[key] : default
    end
  end
end

module Enumerable
  unless respond_to? :max_by
    def max_by(&block)
      return to_enum :max_by unless block

      first = true
      max = nil
      max_cmp = nil

      self.each do |*val|
        if first
          max = val.__svalue
          max_cmp = block.call(*val)
          first = false
        else
          if (cmp = block.call(*val)) > max_cmp
            max = val.__svalue
            max_cmp = cmp
          end
        end
      end
      max
    end
  end

  unless respond_to? :zip
    def zip(arg)
      ary = []
      i = 0

      self.each do |*val|
        a = []
        a.push(val.__svalue)
        begin
          a.push(arg[i])
        rescue
          a.push(nil)
        end
        ary.push(a)
        i += 1
      end
      ary
    end
  end
end
