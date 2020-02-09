# frozen_string_literal: true

require "ffi"

module Bitcount
  module Native
    class << self
      extend FFI::Library

      dl_ext = RbConfig::MAKEFILE_CONFIG['DLEXT']
      begin
        ffi_lib File.expand_path("../bitcount_ext/bitcount_ext.#{dl_ext}", __dir__)
      rescue LoadError
        ffi_lib File.expand_path("bitcount_ext.#{dl_ext}", "#{__dir__}/../../ext")
      end

      attach_function :ext_layout, [], :size_t
      attach_function :ext_popcount, [:size_t], :size_t
      attach_function :ext_nlz, [:size_t], :size_t
      attach_function :ext_ntz, [:size_t], :size_t

      def layout_size
        ext_layout
      rescue
        64
      end

      def popcount(n)
        begin
          ext_popcount(n)
        rescue
          Bitcount::Pure.popcount(n)
        end
      end

      def ntz(n, size = nil)
        size ||= layout_size
        return Bitcount::Pure.ntz(n, size) if layout_size != size
        begin
          ext_ntz(n)
        rescue
          Bitcount::Pure.ntz(n, size)
        end
      end

      def nlz(n, size = nil)
        size ||= layout_size
        return Bitcount::Pure.nlz(n, size) if layout_size != size
        begin
          ext_nlz(n)
        rescue
          Bitcount::Pure.nlz(n, size)
        end
      end

      private

      def layout_error
        raise RangeError, 'number is too large'
      end
    end
  end
end
