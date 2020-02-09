# frozen_string_literal: true

require 'mkmf'

$CFLAGS << ' -std=c99'

if enable_config('march-tune-native', false)
  $CFLAGS << ' -march=native -mtune=native'
end

if enable_config('lto', false)
  $CFLAGS << ' -flto'
  $LDFLAGS << ' -flto'
end

$warnflags = ''
$CFLAGS.gsub!(/[\s+](-ansi|-std=[^\s]+)/, '')

dir_config 'bitcount_ext'

$INCFLAGS << " -I$(srcdir)/bitcount_ext/include"
$VPATH << "$(srcdir)/bitcount_ext/src"
Dir.chdir(__dir__) do
  $VPATH += Dir['bitcount_ext/src/*/'].map { |p| "$(srcdir)/#{p}" }
  $srcs = Dir['bitcount_ext/src/bitcount_ext.c']
end

$LIBRUBYARG = nil
MakeMakefile::LINK_SO << "\nstrip -x $@"

MakeMakefile.send(:remove_const, :EXPORT_PREFIX)
MakeMakefile::EXPORT_PREFIX = nil

create_makefile 'bitcount/bitcount_ext'