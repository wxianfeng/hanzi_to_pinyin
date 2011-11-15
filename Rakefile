# encoding: utf-8

require 'rubygems'
require 'bundler'

require "rake"
require "rspec"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "hanzi_to_pinyin"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

task :build do
  system "gem build hanzi_to_pinyin.gemspec"
end

task :install => :build do
  system "sudo gem install hanzi_to_pinyin-#{HanziToPinyin::VERSION}.gem"
end

task :release => :build do
  puts "Tagging #{HanziToPinyin::VERSION}..."
  system "git tag -a #{HanziToPinyin::VERSION} -m 'Tagging #{HanziToPinyin::VERSION}'"
  puts "Pushing to Github..."
  system "git push --tags"
  puts "Pushing to rubygems.org..."
  system "gem push hanzi_to_pinyin-#{HanziToPinyin::VERSION}.gem"
end

Rspec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

Rspec::Core::RakeTask.new('spec:progress') do |spec|
  spec.rspec_opts = %w(--format progress)
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
task :test => :spec