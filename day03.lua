local lib = require("lib")

local MATCH_COMMA = "([^,]+)"
local DO = "do()"
local DONT = "don't()"

local function sum_line(line)
  local sum = 0
  for match in line:gmatch("mul%(%d%d?%d?,%d%d?%d?%)") do
    local s = match:sub(#"mul(" + 1, #match - 1)
    local xs = s:split(MATCH_COMMA)
    sum = sum + tonumber(xs[1]) * tonumber(xs[2])
  end
  return sum
end

local function part1(filename)
  local lines = lib.load_lines_from_file(filename)
  local sum = 0
  for _, line in ipairs(lines) do
    sum = sum + sum_line(line)
  end
  return sum
end

local function part2(filename)
  local lines = lib.load_lines_from_file(filename)
  local all = table.concat(lines)
  local on = true
  local s = ""
  local sum = 0
  for i = 1, #all do
    s = s .. all:sub(i, i)
    if on and s:sub(#s - #DONT + 1, #s) == DONT then
      sum = sum + sum_line(s)
      on = false
      s = ""
    elseif not on and s:sub(#s - #DO + 1, #s) == DO then
      on = true
      s = ""
    end
  end
  if on and #s > 0 then
    sum = sum + sum_line(s)
  end
  return sum
end

return {
  part1 = part1,
  part2 = part2,
}
