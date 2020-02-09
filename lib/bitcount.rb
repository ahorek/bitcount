# frozen_string_literal: true

require "bitcount/version"
require "bitcount/pure"
begin
  require "bitcount/native"
rescue LoadError
  puts 'ext not loaded'
end

module Bitcount
  class << self
    def popcount(n)
      type_error unless n.is_a?(Integer)
      negative_error if n < 0
      implementation.popcount(n)
    end
    
    def ntz(n, size = nil)
      type_error unless n.is_a?(Integer)
      negative_error if n < 0
      implementation.ntz(n, size)
    end
    
    def nlz(n, size = nil)
      type_error unless n.is_a?(Integer)
      negative_error if n < 0
      implementation.nlz(n, size)
    end
    
    private
    
    def implementation
      defined?(:"Bitcount::Native") ? Bitcount::Native : Bitcount::Pure
    end
    
    def type_error
      raise TypeError, 'not a number'
    end

    def negative_error
      raise ArgumentError, 'number is negative'
    end
  end
end
