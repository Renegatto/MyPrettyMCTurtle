Point = {}

function Point.updated(of,x,y,z,val)
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
function Point.new(x, y, z) return {x, y, z} end
function Point.offset_between(source,destination) -- (Point, Point) -> Point
    return table.map(
      function(a,b)return a-b end, 
      table.zipi(source,destination))
end
