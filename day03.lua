local lib = require("lib")

local MATCH_COMMA = "([^,]+)"

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
  return -1
end

return {
  part1 = part1,
  part2 = part2,
}
