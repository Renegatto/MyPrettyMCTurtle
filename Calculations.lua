
function add(a,b)return a+b end
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

Point = {}
Point.new = function(x, y, z) return {x, y, z} end
Point.offset_between = function(source,destination) -- (Point, Point) -> Point
    return table.map(
      function(a,b)return a-b end, 
      table.zipi(source,destination))
end
Direction = {}
Direction.horisontal = {
      empty     = {0,0,0,0},
      ["NORTH"] = {1,0,0,0},
      ["FRONT"] = {1,0,0,0},
      
      ["EAST"]  = {0,1,0,0},
      ["RIGHT"] = {0,1,0,0},
      
      ["SOUTH"] = {0,0,1,0},
      ["BACK"]  = {0,0,1,0},
      
      ["WEST"]  = {0,0,0,1},
      ["LEFT"]  = {0,0,0,1},
}
Direction.vertical = {
      ["UP"] = 1,
      ["DOWN"] = 0,
}
function show(s,x) print(s..tostring(x)) return x end
Direction.new = function(n,e,s,w) 
  return {n,e,s,w}
end
Direction.by_name = function(name) 
  return Direction.horisontal[name]
end
Direction.new_horisontal = function(up, down)return up end
Direction.horisontal_by_name = function(name) return Direction.vertical[name] end
Direction.from_angle = function(ang) --test
  local result = {[0] = 0,[1] = 0,[2] = 0,[3] = 0}
  result[ang] = 1
  return result
end
Direction.as_angle = function(dir)--test
    return dir[1]*1 + dir[2]*2 + dir[3]*3
end
Direction.rotate_angles = function(rotating,on) --test
    print(string.format("rotating %s ; on %s ; sum %s ; result %s",rotating,on,rotating+on,math.fmod(rotating + on, 3)))
    return math.fmod(rotating + on, 4)
end
Direction.rotate = function(rotating, on)--test
    return Direction.from_angle(
      Direction.rotate_angles(
        Direction.as_angle(rotating),
        Direction.as_angle(on)
      ))
end
Direction.relative_to_absolute = function(relative,absolute)
    return Direction.rotate(absolute,relative)
end 

function Direction.relative(v_dir_name,h_dir_name)
    return {
      vertical = Direction.vertical[v_dir_name],
      horisontal = Direction.horisontal[h_dir_name]
    }
end
function Direction.absolute(v_dir_name,h_dir_name)
    return {
      vertical = Direction.vertical[v_dir_name],
      horisontal = Direction.horisontal[h_dir_name]
    }
end
