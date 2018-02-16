class Zigzag
  def initialize(array_length)
    length = array_length
    rows = cols = length
    @start_number = 1
    @end_number = length ** 2
    @mid_point = @end_number / 2

    @result = Array.new(rows){ Array.new(cols, 0) }
  end

  def rotate_array
    @result.reverse!
    @result.each do |row|
      row.reverse!
    end
  end

  def fill_array_in_zigzag(number, increment_method)
  # assume that X goes from left to right
  # assume that Y goes from top down
    x = 0
    y = 0

    previous_x, previous_y = 0, 0
    current_x, current_y = 0, 0

    number.send(increment_method, @mid_point) do |num|

      @result[y][x] = num

      if previous_x == 0 && previous_y == 0 &&  current_y == 0
        x = 0
        y += 1
      elsif previous_x == current_x && current_y > previous_y
        x += 1
        y -= 1
      elsif previous_y == current_y && current_x > previous_x
        x -= 1
        y += 1
      elsif previous_x > current_x && previous_y < current_y && current_x != 0
        x -= 1
        y += 1
      elsif previous_x < current_x && previous_y > current_y && current_y != 0
        x += 1
        y -= 1
      elsif current_y == 0 && current_x > previous_x
        x += 1
      elsif current_x == 0 && current_y > previous_y
        y += 1
      end

      previous_x = current_x
      previous_y = current_y

      current_x = x
      current_y = y
      end
    @result
  end

  def perform
    @result = fill_array_in_zigzag(@start_number, 'upto')
    rotate_array

    @result = fill_array_in_zigzag(@end_number, 'downto')
    rotate_array
  end

  def print_result
    @result.each do |row|
      row.each do |cell|
        print cell
        if cell < 10
          print "   "
        else
          print "  "
        end
      end
      puts ''
    end
  end
end

# Run the program to see the results.
require 'pp'
puts "Expected result for array 7x7:"
[ [ 1,  3,   4,  10,  11,  21,  22 ],
  [ 2,  5,   9,  12,  20,  23,  34 ],
  [ 6,  8,  13,  19,  24,  33,  35 ],
  [ 7, 14,  18,  25,  32,  36,  43 ],
  [15, 17,  26,  31,  37,  42,  44 ],
  [16, 27,  30,  38,  41,  45,  48 ],
  [28, 29,  39,  40,  46,  47,  49 ]
].each do |row|
  pp row
end
puts '============================'
puts ''
puts "Computered result:"

zigzag_array = Zigzag.new(6)
zigzag_array.perform
zigzag_array.print_result
