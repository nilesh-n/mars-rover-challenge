class Rover
  def initialize(start_position, grid_size)
    set_grid(grid_size)
    set_position(start_position)
  end

  def set_grid(grid_size)
    upper = grid_size.split(" ")
    lower = [0,0]
    @grid = (lower[0]..upper[0].to_i).to_a.product((lower[1]..upper[1].to_i).to_a)
  end

  def grid
    @grid
  end

  def set_position(new_position)
    if is_move_valid?(new_position)
      @current_position = new_position
    else
      @current_position = position
      puts "skipping move instruction, out of grid: #{new_position}"
    end
  end

  def position
    @current_position
  end

  def direction
    position[-1]
  end

  def is_move_valid?(position)
    new_position = coords(position)
    grid.include?(new_position)
  end

  CARDINAL_POINTS = ['N', 'E', 'S', 'W']

  def update_direction(position, new_direction)
    new_position = position.chop + new_direction
    set_position(new_position)
  end

  def turn_left
    direction_index = CARDINAL_POINTS.find_index(direction)
    new_direction = CARDINAL_POINTS[direction_index - 1]
    update_direction(position, new_direction)
  end

  def turn_right
    direction_index = CARDINAL_POINTS.find_index(direction)
    if (direction_index == CARDINAL_POINTS.length - 1)
      new_direction = CARDINAL_POINTS[0]
    else
      new_direction = CARDINAL_POINTS[direction_index + 1]
    end
    update_direction(position, new_direction)
  end

  def coords(position)
    coord_array = position.split(" ")
    x_coord = coord_array[0].to_i
    y_coord = coord_array[1].to_i
    [x_coord, y_coord]
  end

  def move
    x_coord, y_coord = coords(position)
    if direction == 'N'
      y_coord += 1
    elsif direction == "S"
      y_coord -= 1
    elsif direction == "E"
      x_coord += 1
    elsif direction == "W"
      x_coord -= 1
    end

    new_position = "#{x_coord} #{y_coord} #{direction}"
    set_position(new_position)
  end

  def roll_out(movement)
    movement.upcase.split(//).each do |move|
      case move
      when 'L'
        self.turn_left
      when 'R'
        self.turn_right
      when 'M'
        self.move
      else
        puts "skipping move instruction, invalid move instruction: #{move}"
      end
    end
  end
end
