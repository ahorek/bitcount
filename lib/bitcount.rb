require "bitcount/version"

module Bitcount
  class << self
    def layout_size
      64
    end

    def popcount(n)
      type_error unless n.is_a?(Integer)
      negative_error if n < 0
      n.to_s(2).count("1")
    end
    
    def ntz(n, size = layout_size)
      count = 0
      type_error unless n.is_a?(Integer)
      negative_error if n < 0
      bits = n.to_s(2)
      layout_error if bits.size > size
      bits.rjust(size, "0").reverse.each_char do |b|
        (b == '0') ? count += 1 : break
      end
      count
    end
    
    def nlz(n, size = layout_size)
      count = 0
      type_error unless n.is_a?(Integer)
      negative_error if n < 0
      bits = n.to_s(2)
      layout_error if bits.size > size
      bits.rjust(size, "0").each_char do |b|
        (b == '0') ? count += 1 : break
      end
      count
    end
    
    private
    
    def type_error
      raise TypeError, 'not a number'
    end
    
    def layout_error
      raise ArgumentError, 'number is too large'
    end

    def negative_error
      raise ArgumentError, 'number is negative'
    end
  end
end
