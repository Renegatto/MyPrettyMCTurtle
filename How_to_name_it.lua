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
 
-- function Point(x,y) return {x = x, y = y} end
function Point(x, y, z) return {x, y, z} end

local calculations = {
    relative_dir_to_absolute,
    direction_as_angle,
    rotate_direction,
}
calculations.__index = calculations
 
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
table.zipi = function(a, b)
    local result = {}
    for i, v in ipairs(a) do
      result[i] = {a[i], b[i]}
    end
    return result
end
table.map = function(fn,t)
    local result = {}
    for k, v in pairs(t) do
      result[k] = fn(v)
    end
    return result 
end
table.mmap = function(fn,t)
    for k, v in pairs(t) do 
      t[k] = fn(v) 
    end
    return t
end
table.imap = function(fn,t)
    local result = {}
    for i, v in ipairs(t) do
      result[i] = fn(i, v)
    end
    return result
end
function calculations:offset_between_points(source,destination) -- (Point, Point) -> Point
    return table.map(
      function(a,b)return a-b end, 
      table.zipi(source,destination))
end
function set_coordinate(of,x,y,z,val)
   if not of[x] then
     of[x] = {[y] = {[z] = val}}
   else
     if not of[x][y] then
       of[x][y] = {[z] = val}
     else
       of[x][y][z] = val
     end
   end
end
     
table.project = function(fn,xs)
  local result = {}
  for x, ys in ipairs(xs) do
      for y, zs in ipairs(ys) do
        for z, val in ipairs(zs) do
          local new_x, new_y, new_z = table.unpack(fn(x,y,z))
          set_coordinate(result,new_x,new_y,new_z,val) 
        end
      end
   end
   return result
end

function Map(setup)
    
    local absolute_position = function(x,y,z,data)
      return calculations.offset_between_points(
        setup.starting_position, 
        Point(x,y))
    end
   
    local result = {
        state = table.project(absolute_position, setup.goal),
 
        item = function(x,y,z) return result.state[x][y][z] end,
 
        update = function(x,y,z,value)
            set_coordinate(
              result.state, x, y, z, value)
        end,
        
    }
    return result
end
  
    
function test()
    local should_build = {
        {
          {1,1,1,1,1},
          {1,0,0,1,1},
          {0,0,0,1,0},
          {1,1,1,1,0},
        },{
          {1,1,0,1,1},
          {1,0,1,1,1},
          {0,0,0,1,0},
          {1,1,1,1,0},
        }, {
          {1,1,0,1,1},
          {1,0,0,1,1},
          {0,0,1,1,0},
          {1,1,1,1,0},
        }, 
    }
    
    local map = Map(
      {
        goal = should_build, 
        starting_position = Point(2,1,7),
        current_location = Point(-218,534,56),
      }
    )
    print(map.state)
 end
 test()
