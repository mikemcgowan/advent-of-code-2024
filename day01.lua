local lib = require("lib")

local function to_cols(filename)
  local lines = lib.load_lines_from_file(filename)
  local col1 = {}
  local col2 = {}
  for _, line in ipairs(lines) do
    local bits = line:split()
    table.insert(col1, tonumber(bits[1]))
    table.insert(col2, tonumber(bits[2]))
  end
  return col1, col2
end

local function part1(filename)
  local col1, col2 = to_cols(filename)
  table.sort(col1)
  table.sort(col2)
  local sum = 0
  for i = 1, #col1 do
    local delta = math.abs(col1[i] - col2[i])
    sum = sum + delta
  end
  return sum
end

local function part2(filename)
  local col1, col2 = to_cols(filename)
  local cache = {}
  local sum = 0
  for _, v in ipairs(col1) do
    if not cache[v] then
      local c = 0
      for _, w in ipairs(col2) do
        if v == w then
          c = c + 1
        end
      end
      cache[v] = c
    end
    sum = sum + v * cache[v]
  end
  return sum
end

return {
  part1 = part1,
  part2 = part2,
}
