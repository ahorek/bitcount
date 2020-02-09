require "bitcount"

class Integer
  def popcount
    Bitcount.popcount(self)
  end

  def ntz(size = Bitcount.layout_size)
    Bitcount.ntz(self, size)
  end

  def nlz(size = Bitcount.layout_size)
    Bitcount.nlz(self, size)
  end
end