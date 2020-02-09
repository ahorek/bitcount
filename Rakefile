# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rake/extensiontask'

RSpec::Core::RakeTask.new(:spec)
task default: :spec

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

CLEAN.include 'lib/bitcount/bitcount_ext.{so,bundle,dll}',
              'ext/*.{o,so,bundle,dll}', 'ext/Makefile'