local lib = require("lib")

local TRAILHEAD = 0
local TRAILEND = 9

local function lines_to_grid(lines)
  local grid = {}
  for _, line in ipairs(lines) do
    local xs = {}
    for col = 1, #line do
      local c = line:sub(col, col)
      table.insert(xs, tonumber(c))
    end
    table.insert(grid, xs)
  end
  return grid
end

local function insert_point_if_not_exists(trailends, i, j)
  local exists = false
  for _, v in ipairs(trailends) do
    if v.i == i and v.j == j then
      exists = true
      break
    end
  end
  if not exists then
    table.insert(trailends, { i = i, j = j })
  end
end

local function count_paths_from(grid, i, j, n, trailends)
  assert(grid[i][j] == n)
  if grid[i][j] == TRAILEND then
    insert_point_if_not_exists(trailends, i, j)
    return
  end
  local next = n + 1
  if i > 1 and grid[i - 1][j] == next then
    count_paths_from(grid, i - 1, j, next, trailends)
  end
  if i < #grid and grid[i + 1][j] == next then
    count_paths_from(grid, i + 1, j, next, trailends)
  end
  if j > 1 and grid[i][j - 1] == next then
    count_paths_from(grid, i, j - 1, next, trailends)
  end
  if j < #grid[i] and grid[i][j + 1] == next then
    count_paths_from(grid, i, j + 1, next, trailends)
  end
end

local function go(grid)
  local sum = 0
  for i = 1, #grid do
    for j = 1, #grid[i] do
      if grid[i][j] == TRAILHEAD then
        local trailends = {}
        count_paths_from(grid, i, j, TRAILHEAD, trailends)
        sum = sum + #trailends
      end
    end
  end
  return sum
end

local function part1(filename)
  local lines = lib.load_lines_from_file(filename)
  return go(lines_to_grid(lines))
end

local function part2(filename)
  local lines = lib.load_lines_from_file(filename)
  return -1
end

return {
  part1 = part1,
  part2 = part2,
}
