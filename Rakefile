# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rake/extensiontask'

gem_spec = Gem::Specification.load("bitcount.gemspec")

module FixRequiredRubyVersion
  def required_ruby_version=(*); end
end
Gem::Specification.send(:prepend, FixRequiredRubyVersion)

Rake::ExtensionTask.new('bitcount_ext', gem_spec) do |ext|
  ext.name = 'bitcount_ext'
  ext.ext_dir = 'ext'
  ext.lib_dir = 'lib/bitcount_ext'
end

CLEAN.include 'lib/bitcount_ext/bitcount_ext.{so,bundle,dll}',
              'ext/*.{o,so,bundle,dll}', 'ext/Makefile', 'tmp'

RSpec::Core::RakeTask.new(:spec)
task test: 'compile:bitcount_ext' do
  Rake::Task['spec'].invoke
end
task default: :test
