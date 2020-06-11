Point = {}

function Point.new(x, y, z) return {x, y, z} end
function Point.offset_between(source,destination) -- (Point, Point) -> Point
    return table.map(
      function(a,b)return a-b end, 
      table.zipi(source,destination))
end
