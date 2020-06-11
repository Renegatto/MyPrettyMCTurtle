table.find = function(predicate,t,otherwise)
  local result = {}
  for k,v in pairs(t) do
    if predicate(v) then
      return k
    end
  end
  return otherwise
end
table.zipi = function(a, b)
    local result = {}
    for i, v in ipairs(a) do
      result[i] = {a[i], b[i]}
    end
    return result
end              
table.map = function(fn,t)--+
    local result = {}
    for k, v in pairs(t) do
      result[k] = fn(v)
    end
    return result 
end    
table.reduce = function(fn,t)--+
  local acc = nil
  local first = false
  for k,v in pairs(t) do
    if first then
      acc = v
    else
      acc = fn(acc,v)
    end
  end
  return acc
end
table.fold = function(fn2,t,acc)--+
  for k,v in ipairs(t) do
    acc = fn2(acc,v)
  end
  return acc
end
table.range = function(from,to)--+
  local result = {}
  for i = from, to do
    result[i] = i
  end
  return result
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
