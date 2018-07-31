require 'minitest/autorun'
require 'minitest/reporters'
require './rover'

# used to provide output in a documentation format similar to RSpec
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestRover < Minitest::Test
  def setup
    @rover = Rover.new('1 1 N', '3 3')
  end

  def test_grid_creation
    grid_points = [[0, 0], [0, 1], [0, 2], [0, 3], [1, 0], [1, 1], [1, 2], [1, 3],
                   [2, 0], [2, 1], [2, 2], [2, 3], [3, 0], [3, 1], [3, 2], [3, 3]]
    assert_equal grid_points, @rover.grid
  end

  def test_if_move_is_valid_on_grid
    assert @rover.is_move_valid?('1 2 N')
    refute @rover.is_move_valid?('3 4 S')
    assert @rover.is_move_valid?('2 2 E')
  end

  def test_current_rover_position
    assert_equal "1 1 N", @rover.position
  end

  def test_changing_rover_position
    @rover.set_position('2 3 W')
    assert_equal "2 3 W", @rover.position
  end

  def test_getting_rover_direction
    assert_equal 'N', @rover.direction
  end

  def test_updating_direction
    @rover.set_position('2 3 W')
    assert_equal 'W', @rover.direction
  end

  def test_turning_rover_left
    @rover.turn_left
    assert_equal "1 1 W", @rover.position

    @rover.set_position('2 3 W')
    @rover.turn_left
    assert_equal "2 3 S", @rover.position
    @rover.set_position('2 3 S')
    @rover.turn_left
    assert_equal "2 3 E", @rover.position
    @rover.set_position('2 3 E')
    @rover.turn_left
    assert_equal "2 3 N", @rover.position
    @rover.turn_left
    assert_equal "2 3 W", @rover.position
  end

  def test_turning_rover_right
    @rover.turn_right
    assert_equal "1 1 E", @rover.position

    @rover.set_position('2 3 W')
    @rover.turn_right
    assert_equal "2 3 N", @rover.position
    @rover.set_position('2 3 S')
    @rover.turn_right
    assert_equal "2 3 W", @rover.position
    @rover.set_position('2 3 E')
    @rover.turn_right
    assert_equal "2 3 S", @rover.position
    @rover.turn_right
    assert_equal "2 3 W", @rover.position
  end

  def test_rover_coords
    assert_equal [1,1], @rover.coords(@rover.position)
  end

  def test_rover_movement
    @rover.move
    assert_equal "1 2 N", @rover.position
    @rover.move
    assert_equal "1 3 N", @rover.position
    @rover.turn_right
    @rover.move
    assert_equal "2 3 E", @rover.position
    @rover.move
    assert_equal "3 3 E", @rover.position
    @rover.turn_right
    @rover.turn_right
    @rover.move
    assert_equal "2 3 W", @rover.position
  end

  def test_sample_rover_movement
    @rover.set_position('1 2 N')
    @rover.turn_left
    @rover.move
    @rover.turn_left
    @rover.move
    @rover.turn_left
    @rover.move
    @rover.turn_left
    @rover.move
    @rover.move
    assert_equal "1 3 N", @rover.position
  end

  def test_full_rover_movement
    @rover.set_position('1 2 N')
    @rover.roll_out("LMLMLMLMM")
    assert_equal "1 3 N", @rover.position

    @rover.set_position('1 3 E')
    @rover.roll_out("MMRMMRMRRM")
    assert_equal "3 1 E", @rover.position
  end

  def test_rover_movement_off_grid
    @rover.set_position('3 3 N')
    @rover.roll_out("MMMMM")
    assert_equal "3 3 N", @rover.position

    @rover.set_position('3 3 S')
    @rover.roll_out("MMMMM")
    assert_equal "3 0 S", @rover.position

    @rover.set_position('3 3 E')
    @rover.roll_out("MMMMM")
    assert_equal "3 3 E", @rover.position

    @rover.set_position('3 3 W')
    @rover.roll_out("MMMMM")
    assert_equal "0 3 W", @rover.position
  end

  def test_rover_movement_invalid_instructions
    @rover.set_position('1 2 N')
    @rover.roll_out("LMxLMyyLMLMMq")
    assert_equal "1 3 N", @rover.position

    @rover.set_position('1 2 N')
    @rover.roll_out("")
    assert_equal "1 2 N", @rover.position

    @rover.set_position('1 2 N')
    @rover.roll_out("QWFdfiouXCvvNNz")
    assert_equal "1 2 N", @rover.position
  end
end
