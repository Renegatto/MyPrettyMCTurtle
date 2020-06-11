
function add(a,b)return a+b end

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
function Direction.new(n,e,s,w) 
  return {n,e,s,w}
end
function Direction.by_name(name) 
  return Direction.horisontal[name]
end
function Direction.new_horisontal(up, down)return up end
function Direction.horisontal_by_name(name) return Direction.vertical[name] end
function Direction.from_angle(ang) --test
  local result = {[0] = 0,[1] = 0,[2] = 0,[3] = 0}
  result[ang] = 1
  return result
end
function Direction.as_angle(dir)--test
    return dir[1]*1 + dir[2]*2 + dir[3]*3
end
function Direction.rotate_angles(rotating,on) --test
    print(string.format("rotating %s ; on %s ; sum %s ; result %s",rotating,on,rotating+on,math.fmod(rotating + on, 3)))
    return math.fmod(rotating + on, 4)
end
function Direction.rotate(rotating, on)--test
    return Direction.from_angle(
      Direction.rotate_angles(
        Direction.as_angle(rotating),
        Direction.as_angle(on)
      ))
end
function Direction.relative_to_absolute(relative,absolute)
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
