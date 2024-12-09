local lib = require("lib")

local DAYS = 9

for x = 1, DAYS do
  local d = tostring(x)
  if #d < 2 then
    d = "0" .. d
  end
  local day = require("day" .. d)
  local filename = "./inputs/day" .. d .. ".txt"
  print(("Day " .. x):add_colour(lib.colours.cyan))
  print(("  Part 1 = " .. day.part1(filename)):add_colour(lib.colours.green))
  print(("  Part 2 = " .. day.part2(filename)):add_colour(lib.colours.green))
end
