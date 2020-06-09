local direction = {
    horisontal = {
      ["NORTH"] = {1,0,0,0},
      ["EAST"]  = {0,1,0,0},
      ["SOUTH"] = {0,0,1,0},
      ["WEST"]  = {0,0,0,1},
    },
    vertical = {
      ["UP"] = 1,
      ["DOWN"] = 0,
    },
  }
  
  local constructors = {
    RelativeDirection
  }
  constructors.__index = constructors
  
  function constructors:RelativeDirection(v_dir_name,h_dir_name)
      local hor = direction.horisontal[h_dir_name]
      return {
        horisontal = {
          up
        }
      }
  end

function Point(x,y) return {x = x, y = y} end

local calculations = {
    relative_dir_to_absolute,
    direction_as_angle,
    rotate_direction,
}
local calculations.__index = calculations

function calculations:relative_dir_to_absolute(dir)
    return Direction
end

function calculations:direction_as_angle(dir) --0,1,0,0 -> 0100
    return dir.north + dir.east*10 + dir.south*100 + dir.west*1000
end
    
function calculations:rotate_direction(rotating, on)
    return math.fmod(
    (calculations.direction_as_angle(dir1) + 
    calculations.direction_as_angle(dir2)) / 1000
    )
end
  
function calculations:offset_between_points(source,destination) -- (Point, Point) -> Point
    return Point(source.x - destination.x, source.y - destination.y) 
end
  
function Map(setup)
    local coordinates_map = Table.mapi(
        function(row,y)
            return Table.mapi(
                function(elem,x)
                    local p = )
                    return {
                        point = calculations.offset_between_points(
                            setup.starting_position, 
                            Point(x,y)),
                        data = data 
                    }
                end,
                row,
            )
        end,
        setup.goal,
    )
    local result = {
        state = {},

        item = function(x,y,z) return result.state[x][y][z] end,

        update = function(x,y,z,value)
            local prev = result.state[x][y][z]
            result.state[x][y][z] = value
            return prev
        end,
        
    }
    return result
end
  
    
function test()
    local current_map = {
        {1,1,0,1,1},
        {1,0,0,1,1},
        {0,0,0,1,0},
        {1,1,1,1,0},    
    }
    local should_build = {
        {1,0,0,0,1},
        {1,0,1,1,1},
        {1,0,0,0,1},
        {1,1,1,0,1}, 
    }
    local map = Map({
        goal = should_build, 
        starting_position = Point(2,1),
        current_location = Point(-218,534)},
    })
