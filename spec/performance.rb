RSpec.describe Bitcount do
  def iterations
    1000
  end

  it "popcount" do
    puts "popcount"
    puts Benchmark.measure {
      i = 0
      while(i < iterations)
        i += 1
        x = 0
        1.upto(100) do |n|
          x + Bitcount.popcount(n)
        end
      end
    }
  end

  it "nlz" do
    puts "nlz"
    puts Benchmark.measure {
      i = 0
      while(i < iterations)
        i += 1
        x = 0
        1.upto(100) do |n|
          x + Bitcount.nlz(n)
        end
      end
    }
  end

  it "ntz" do
    puts "ntz"
    puts Benchmark.measure {
      i = 0
      while(i < iterations)
        i += 1
        x = 0
        1.upto(100) do |n|
          x + Bitcount.nlz(n)
        end
      end
    }
  end
end
