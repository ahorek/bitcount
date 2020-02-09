# frozen_string_literal: true

require "bitcount"

class Integer
  def popcount
    Bitcount.popcount(self)
  end

  def ntz(size = nil)
    Bitcount.ntz(self, size)
  end

  def nlz(size = nil)
    Bitcount.nlz(self, size)
  end
end