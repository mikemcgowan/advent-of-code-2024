local lib = require("lib")

local function append(n, xs)
  local ys = { n }
  for i = 3, #xs do
    table.insert(ys, xs[i])
  end
  return ys
end

local function recurse(expected, concat, xs)
  if #xs == 1 then
    return xs[1] == expected
  end
  local x = xs[1]
  if x > expected then
    return false
  end
  local y = xs[2]
  if recurse(expected, concat, append(x + y, xs)) then
    return true
  elseif recurse(expected, concat, append(x * y, xs)) then
    return true
  elseif concat and recurse(expected, concat, append(tonumber(tostring(x) .. tostring(y)), xs)) then
    return true
  else
    return false
  end
end

local function calc(v, concat)
  local bits = v:split()
  local expected = tonumber(bits[1]:sub(1, #bits[1] - 1))
  local xs = {}
  for i = 2, #bits do
    table.insert(xs, tonumber(bits[i]))
  end
  local found = recurse(expected, concat, xs)
  return found and expected or nil
end

local function go(filename, concat)
  local lines = lib.load_lines_from_file(filename)
  local sum = 0
  for _, v in ipairs(lines) do
    local result = calc(v, concat)
    if result then
      sum = sum + result
    end
  end
  return sum
end

local function part1(filename)
  return go(filename, false)
end

local function part2(filename)
  return go(filename, true)
end

return {
  part1 = part1,
  part2 = part2,
}
