direction = {
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

constructors = {
  
  RelativeDirection = function(v_dir_name,h_dir_name)
    local hor = direction.horisontal[h_dir_name]
    return {
      horisontal = {
        up
      }
    }
  
}

local Calculations = {
  relative_dir_to_absolute = function(dir)
    return Direction
  direction_as_angle = function(dir) --0,1,0,0 -> 0100
    return dir.north + dir.east*10 + dir.south*100 + dir.west*1000
  end
  
  rotate_direction = function(rotating, on)
    return math.fmod(
      (direction_as_angle(dir1) + direction_as_angle(dir2)) / 1000
    )
  end
}



function Map()
  return {
    state = {},
    item = function(x,y,z) return state[x][y][z] end,
    update = function(x,y,z,value)
      local prev = state [x][y][z]
      state[x][y][z] = value
      return prev
    end,
  }
end

  
  
