#!/usr/bin/env ruby

require 'rubygems'
require './src/program'

if __FILE__ == $0
    $LOAD_PATH.unshift(File.dirname(__FILE__))
    Program.new.set_options!(ARGV)
end

