# frozen_string_literal: true

RSpec.describe Bitcount do
  it "has a version number" do
    expect(Bitcount::VERSION).not_to be nil
  end

  context "popcount" do
    it 'one' do
      expect(Bitcount.popcount(1)).to eq(1)
    end

    it 'zero' do
      expect(Bitcount.popcount(0)).to eq(0)
    end

    it '1..100' do
      1.upto(100) do |n|
        expect(Bitcount.popcount(n)).to eq(n.abs.to_s(2).count("1"))
      end
    end

    it '3**(1..100)' do
      1.upto(100) do |k|
        n = 3 ** k
        expect(Bitcount.popcount(n)).to eq(n.abs.to_s(2).count("1"))
      end
    end

    it 'map' do
      expect(1.upto(100).map{ |n| Bitcount.popcount(n) }).to eq(
      [1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2,
        3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2,
        3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4,
        5, 3, 4, 4, 5, 4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2,
        3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4,
        5, 4, 5, 5, 6, 2, 3, 3, 4, 3])
    end

    it '65535' do
      expect(Bitcount.popcount(65535)).to eq(16)
    end

    it 'big' do
      expect(Bitcount.popcount(655350000000000000000000000)).to eq(36)
    end

    it 'errors' do
      expect { Bitcount.popcount(nil) }.to raise_error(TypeError)
      expect { Bitcount.popcount(2.5) }.to raise_error(TypeError)
      expect { Bitcount.popcount('2') }.to raise_error(TypeError)
      expect { Bitcount.popcount(-1) }.to raise_error(ArgumentError)
    end
  end

  context 'nlz' do
    it "one" do
      expect(Bitcount.nlz(1)).to eq(63)
    end

    it 'zero' do
      expect(Bitcount.nlz(0)).to eq(64)
    end

    it '65535' do
      expect(Bitcount.nlz(65535)).to eq(48)
    end

    it 'layout' do
      expect(Bitcount.nlz(1, 32)).to eq(31)
    end

    it 'big' do
      expect { Bitcount.nlz(655350000000000000000000000) }.to raise_error(RangeError)
    end

    it 'map' do
      expect(1.upto(100).map{ |n| Bitcount.nlz(n) }).to eq(
      [63,
        62,62,
        61,61,61,61,
        60,60,60,60,60,60,60,60,
        59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,59,
        58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,
        57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57,57
      ])
    end

    it 'errors' do
      expect { Bitcount.nlz(nil) }.to raise_error(TypeError)
      expect { Bitcount.nlz(2.5) }.to raise_error(TypeError)
      expect { Bitcount.nlz('2') }.to raise_error(TypeError)
      expect { Bitcount.nlz(-1) }.to raise_error(ArgumentError)
    end
  end

  context 'ntz' do
    it "one" do
      expect(Bitcount.ntz(1)).to eq(0)
    end

    it 'zero' do
      expect(Bitcount.ntz(0)).to eq(64)
    end

    it '65535' do
      expect(Bitcount.ntz(65535)).to eq(0)
    end

    it 'big' do
      expect { Bitcount.ntz(655350000000000000000000000) }.to raise_error(RangeError)
    end

    it 'layout' do
      expect(Bitcount.ntz(2147483648, 32)).to eq(31)
    end

    it 'map' do
      expect(1.upto(100).map{ |n| Bitcount.ntz(n) }).to eq(
      [0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0,
        1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0,
        2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0,
        1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 6, 0, 1, 0, 2, 0, 1, 0,
        3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2, 0, 1, 0, 3, 0,
        1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2])
    end

    it 'errors' do
      expect { Bitcount.ntz(nil) }.to raise_error(TypeError)
      expect { Bitcount.ntz(2.5) }.to raise_error(TypeError)
      expect { Bitcount.ntz('2') }.to raise_error(TypeError)
      expect { Bitcount.ntz(-1) }.to raise_error(ArgumentError)
    end
  end

  it 'extend integer' do
    expect { 1.popcount }.to raise_error(NoMethodError)
    expect { 1.nlz }.to raise_error(NoMethodError)
    expect { 1.ntz }.to raise_error(NoMethodError)
    require 'bitcount/integer'
    expect(1.popcount).to eq(1)
    expect(1.nlz).to eq(63)
    expect(1.ntz).to eq(0)
  end
end
