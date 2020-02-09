# frozen_string_literal: true

module Bitcount
  module Pure
    class << self
      def layout_size
        64
      end

      def popcount(n)
        n.to_s(2).count("1")
      end

      def ntz(n, size = nil)
        size ||= layout_size
        count = 0
        bits = n.to_s(2)
        layout_error if bits.size > size
        bits.rjust(size, "0").reverse.each_char do |b|
          (b == '0') ? count += 1 : break
        end
        count
      end

      def nlz(n, size = nil)
        size ||= layout_size
        count = 0
        bits = n.to_s(2)
        layout_error if bits.size > size
        bits.rjust(size, "0").each_char do |b|
          (b == '0') ? count += 1 : break
        end
        count
      end

      private

      def layout_error
        raise RangeError, 'number is too large'
      end
    end
  end
end
