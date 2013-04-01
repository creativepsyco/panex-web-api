#!/usr/bin/env ruby

require 'fileutils'

puts ARGV

input_dir = ARGV[0]
output_dir = ARGV[1]

# Addidtional params
Dir.foreach(input_dir) do |item|
  next if item == '.' or item == '..'
  # do work on real items
  puts item
  name = File.basename(item)
  abs_input_path = "#{input_dir}/#{name}"
  dest_file = "#{output_dir}/output_#{name}"
  FileUtils.copy_file abs_input_path, dest_file
  puts "copying to #{dest_file}"
end