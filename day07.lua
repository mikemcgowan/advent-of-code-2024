local lib = require("lib")

local function recurse(expected, concat, xs, results)
  if #xs == 1 then
    table.insert(results, xs[1])
    return
  end
  local x = xs[1]
  local y = xs[2]

  -- add
  local ys = { x + y }
  for i = 3, #xs do
    table.insert(ys, xs[i])
  end
  recurse(expected, concat, ys, results)

  -- multiply
  local zs = { x * y }
  for i = 3, #xs do
    table.insert(zs, xs[i])
  end
  recurse(expected, concat, zs, results)

  -- concat
  if concat then
    local cs = { tonumber(tostring(x) .. tostring(y)) }
    for i = 3, #xs do
      table.insert(cs, xs[i])
    end
    recurse(expected, concat, cs, results)
  end
end

local function calc(v, concat)
  local bits = v:split()
  local expected = tonumber(bits[1]:sub(1, #bits[1] - 1))
  local xs = {}
  for i = 2, #bits do
    table.insert(xs, tonumber(bits[i]))
  end
  local results = {}
  recurse(expected, concat, xs, results)
  if lib.any(results, function(result)
    return result == expected
  end) then
    return expected
  end
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
