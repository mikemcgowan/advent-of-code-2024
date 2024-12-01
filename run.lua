local lib = require("lib")

local d = arg[1]
if not d then
  print(("Missing arg 'day'"):add_colour(lib.colours.yellow))
  os.exit(1)
end
if #d < 2 then
  d = "0" .. d
end

local day = require("day" .. d)
print(("Part 1 = " .. day.part1("./inputs/day" .. d .. ".txt")):add_colour(lib.colours.green))
print(("Part 2 = " .. day.part2("./inputs/day" .. d .. ".txt")):add_colour(lib.colours.green))
