local lib = require("lib")

local ANTINODE = "#"
local DOT = "."

local function lines_to_grid(lines)
  local grid = {}
  for _, line in ipairs(lines) do
    local xs = {}
    for col = 1, #line do
      local c = line:sub(col, col)
      table.insert(xs, c)
    end
    table.insert(grid, xs)
  end
  return grid
end

local function in_bounds(antinodes, i, j)
  return i > 0 and j > 0 and i <= #antinodes and j <= #antinodes[1]
end

local function mark_antinodes(antenna, i, j, antinodes, is_part_2)
  for _, p in ipairs(antenna) do
    if is_part_2 then
      antinodes[p.i][p.j] = ANTINODE
    end
    local di = i - p.i
    local dj = j - p.j
    if di ~= 0 or dj ~= 0 then
      local ai = i + di
      local aj = j + dj
      if in_bounds(antinodes, ai, aj) then
        antinodes[ai][aj] = ANTINODE
      end
      if is_part_2 then
        local n = 1
        local b = true
        repeat
          n = n + 1
          ai = i + n * di
          aj = j + n * dj
          b = in_bounds(antinodes, ai, aj)
          if b then
            antinodes[ai][aj] = ANTINODE
          end
        until not b
      end
    end
  end
end

local function get_antenna(grid)
  local antenna = {}
  for i = 1, #grid do
    for j = 1, #grid[i] do
      local c = grid[i][j]
      if c ~= DOT then
        local p = { i = i, j = j }
        if not antenna[c] then
          antenna[c] = { p }
        else
          table.insert(antenna[c], p)
        end
      end
    end
  end
  return antenna
end

local function go(grid, antinodes, is_part_2)
  local antenna = get_antenna(grid)
  for i = 1, #grid do
    for j = 1, #grid[i] do
      local c = grid[i][j]
      if c ~= DOT and #antenna[c] > 1 then
        mark_antinodes(antenna[c], i, j, antinodes, is_part_2)
      end
    end
  end
end

local function count_antinodes(antinodes)
  local count = 0
  for i = 1, #antinodes do
    for j = 1, #antinodes[i] do
      if antinodes[i][j] == ANTINODE then
        count = count + 1
      end
    end
  end
  return count
end

local function part(filename, is_part_2)
  local lines = lib.load_lines_from_file(filename)
  local grid = lines_to_grid(lines)
  local antinodes = lines_to_grid(lines)
  go(grid, antinodes, is_part_2)
  return count_antinodes(antinodes)
end

local function part1(filename)
  return part(filename, false)
end

local function part2(filename)
  return part(filename, true)
end

return {
  part1 = part1,
  part2 = part2,
}
