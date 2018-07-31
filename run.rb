require 'rubygems'
require 'bundler/setup'
require './rover'

if ARGV.length != 1
  puts "Please enter the input filename as a parameter. Example: ruby run.rb input.txt"
  puts "Example: '$ ruby run.rb input.txt'"
  exit;
end

filename = ARGV.first
unless File.exists? filename
  puts "Cannot find input file: #{filename}"
  puts "Please use another file."
  exit
end

input_data = IO.readlines(filename)
input_data.each { |line| line.chomp! }
input_data.delete_if { |line| line.chomp.empty? }
grid = input_data.first
input_data.shift

puts "Grid size: #{grid}"

def run_simulation(start_position, movement, grid, count)
  rover = Rover.new(start_position, grid)
  rover.roll_out(movement)

  puts ""
  puts "Rover #{count}"
  puts "Start position: #{start_position}"
  puts "Movement set  : #{movement}"
  puts "Final position: #{rover.position}"
end

count = 1
while input_data.any?
  start_position = input_data[0]
  movement = input_data[1]
  run_simulation(start_position, movement, grid, count)
  input_data.shift(2)
  count += 1
end
