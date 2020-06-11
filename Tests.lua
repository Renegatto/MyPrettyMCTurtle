require "Calculations"

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
  local rotates_for_identity = {
    {rotates = 4,   ang = Direction.from_angle(1)},
    {rotates = 2,   ang = Direction.from_angle(2)},
    {rotates = 4,   ang = Direction.from_angle(3)},
    {rotates = 1,   ang = Direction.from_angle(0)},
  }
  local rotates_for_not_identity = {
    {rotates = 3,   ang = Direction.from_angle(1)},
    {rotates = 1,   ang = Direction.from_angle(2)},
    {rotates = 2,   ang = Direction.from_angle(3)},
  } 
  
  local rand = function() return Direction.from_angle(math.random(0,3)) end
  
  local rnd = rand()

--: [x:[ang -> y:ang]] where fold apply z x = z
  local rotation_sequences = function(rotations) return-- result of 
   table.map(            -- [[(int -> int)]]
     function(rotates)return

       table.repeat(     -- (a -> (Direction -> Direction)) -> [int] -> [(Direction -> Direction)]
         flip(curry(Direction.rotate))(rotates.ang),
         ),
         rotates.rotates
       )
    end, 
    rotations
   )
  end

  local rotation_seqs_that_folds_into_identity =
     rotation_sequences(rotations_for_identity)
  local rotation_seqs_that_not_folds_into_identity =
     rotation_sequences(rotations_for_not_identity)

  local identity_rotate_results = 
    map(
       flip(curry(table.fold(apply))(rnd),
       rotation_seqs_that_folds_into_identity
    )
  local non_identity_rotate_results = 
    map(
       flip(curry(table.fold(apply))(rnd),
       rotation_seqs_that_not_folds_into_identity
    )

  table.map(
    function(x) assert(
       x == Direction.as_angle(rnd), 
       string.format("Fail: Rotating has no identity that must be. Expected angle %s, got %s.", Direction.as_angle(rnd)
     ))
    end,
    table.map(
      Direction.as_angle,
      identity_rotate_results
    )
  )
  table.map(
    function(x) assert(
       x != Direction.as_angle(rnd), 
       string.format("test failed "..tostring(x).."; "..tostring(Direction.as_angle(rnd)) ) end,
    table.map(
      Direction.as_angle,
      non_identity_rotate_results
    )
  )

end

--print(
--  table.fold(
--    function(acc,fn1)return fn1(acc) end,
--    table.map(
--      const(function(acc)return acc+acc end), 
--      table.range(1,100)
--    ),
--    1
--   )
--)
for x=0,1000 do
   ang_conversions()
   rotate_test()
end

