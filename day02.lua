local lib = require("lib")

local function is_delta_unsafe(d)
  d = math.abs(d)
  return d < 1 or d > 3
end

local function is_safe_part1(values)
  local prev = values[1]
  local asc = values[2] > values[1]
  for i = 2, #values do
    local value = values[i]
    if is_delta_unsafe(value - prev) or (asc and value < prev) or (not asc and value > prev) then
      return false
    end
    prev = value
  end
  return true
end

local function is_safe_part2(values)
  if is_safe_part1(values) then
    return true
  end
  for i = 1, #values do
    local t = {}
    for j = 1, #values do
      if i ~= j then
        table.insert(t, values[j])
      end
    end
    if is_safe_part1(t) then
      return true
    end
  end
  return false
end

local function go(filename, f)
  local lines = lib.load_lines_from_file(filename)
  local safe_lines = lib.filter(lines, function(line)
    local values = lib.map(line:split(), function(value)
      return tonumber(value)
    end)
    return f(values)
  end)
  return #safe_lines
end

local function part1(filename)
  return go(filename, function(x)
    return is_safe_part1(x)
  end)
end

local function part2(filename)
  return go(filename, function(x)
    return is_safe_part2(x)
  end)
end

return {
  part1 = part1,
  part2 = part2,
}
