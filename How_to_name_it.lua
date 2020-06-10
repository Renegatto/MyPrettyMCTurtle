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
function nat(x)
    return (x >= 0 and x) or 0
end
local Direction = {}
Direction.new = function(n,e,s,w) 
  return {n,e,s,w}
end
Direction.from_angle = function(ang)
  return Direction.new(
    nat(math.floor(ang/1000)),
    nat(9-math.floor(ang/100)),
    nat(99-math.floor(ang/10)),
    nat(999-ang)
  )
end
Direction.as_angle = function(dir) --0,1,0,0 -> 0100
    return dir[4] + dir[3]*10 + dir[2]*100 + dir[1]*1000
end
    
Direction.rotate = function(rotating, on)
    return Direction.from_angle(math.fmod(
    (Direction.as_angle(dir1) + 
     Direction.as_angle(dir2)) / 1000))
end
Direction.relative_to_absolute = function(relative,absolute)
    return Direction.rotate(absolute,relative)
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
test = {}
test.rotates = function()
   local randang = (function()
     local choice = math.random(0,3)
     print(choice)
     return math.floor(math.pow(10,choice))
   end)
   local ang = randang()
   print(table.unpack(Direction.from_angle(ang)))
   local k =  {
     Direction.as_angle(
       Direction.from_angle(ang)), ang}
   print(k[1],k[2])
   assert(k[1]==k[2],"as_angle or from_angle failed test")
end
function testt()
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
 end
 for x=0,100 do
   test.rotates()
 end
