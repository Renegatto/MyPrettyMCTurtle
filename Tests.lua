require "table_extension"
require "direction"
require "functional"
function apply(x,f) return f(x) end
function show(s,x) print(s..tostring(x)) return x end
function showt(s,t) 
  for k, v in pairs(t) do
    print(s..tostring(v)) 
  end
  return t 
end
function showa(s,t)
  print(string.format("%s (n %s,e %s,s %s ,w %s)",s,t[0],t[1],t[2],t[3]))
  return t
end
showa("n",Direction.from_angle(0))
showa("e",Direction.from_angle(1))
showa("s",Direction.from_angle(2))
showa("w",Direction.from_angle(3))
function ang_conversions()
   local ang = math.random(0,3)
   
   assert(
    Direction.as_angle(Direction.from_angle(ang)) == ang,
    "as_angle or from_angle failed test"
   )
   
end
function const(x) return function(ignored) return x end end
function rotating_identity_test()
  local rotations_for_identity = {
    {rotates = 4,   ang = Direction.from_angle(1)},
    {rotates = 2,   ang = Direction.from_angle(2)},
    {rotates = 4,   ang = Direction.from_angle(3)},
    {rotates = 1,   ang = Direction.from_angle(0)},
  }
  local rotations_for_not_identity = {
    {rotates = 3,   ang = Direction.from_angle(1)},
    {rotates = 1,   ang = Direction.from_angle(2)},
    {rotates = 2,   ang = Direction.from_angle(3)},
  } 
  
  local rand = function() return Direction.from_angle(math.random(0,3)) end
  
  local rotate = curry2(Direction.rotate) -- ang -> ang
  
  local rnd = rand()

--: [x:[ang -> y:ang]] where fold apply z x = z

  local rotation_sequences = cmap(  -- [Rotate] -> [[(ang -> ang)]]
      function(rotates)return       -- Rotate -> [(ang->ang)]
  
         table.repeat1(             -- [f:(ang->ang)] where all f are structurally equal
           rotate(rotates.ang),     -- ang -> ang
           rotates.rotates          -- int
         )
         
      end
  )

  local rotation_seqs_that_folds_into_identity =      -- [[ang->ang]]
     rotation_sequences(rotations_for_identity)
  local rotation_seqs_that_not_folds_into_identity =  -- [[ang->ang]]
     rotation_sequences(rotations_for_not_identity)

  local rotate_results = cmap(cfold(apply)(rnd))     -- [[ang->ang]] -> [ang]

  local identity_rotate_results     = rotate_results(rotation_seqs_that_folds_into_identity)      --[ang]
  local non_identity_rotate_results = rotate_results(rotation_seqs_that_not_folds_into_identity)  --[ang]

  map( -- checking identity cases
    function(x) assert( -- ang -> Assert ang
       x == Direction.as_angle(rnd), 
       string.format("Fail: Rotating has no identity that must be. Expected angle %s, got %s.",
          x,
          Direction.as_angle(rnd)))
    end,
    map(
      Direction.as_angle,
      identity_rotate_results
    )
  )
  map( -- checking non identity cases
    function(x) assert(
       x ~= Direction.as_angle(rnd), 
       string.format("Fail: Rotating has wrong identity. Expected, that angle %s not equal to %s.", 
          x, 
          Direction.as_angle(rnd)))
    end, 
    map(
      Direction.as_angle,
      non_identity_rotate_results
    )
  )

end

for x=0,1000 do
   ang_conversions()
   rotating_identity_test()
end

