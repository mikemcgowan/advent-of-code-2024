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

local function insert_point(distinct_trails, trailends, p)
  if not distinct_trails then
    for _, q in ipairs(trailends) do
      if q.i == p.i and q.j == p.j then
        return
      end
    end
  end
  table.insert(trailends, { i = p.i, j = p.j })
end

local function in_bounds(grid, i, j)
  return i > 0 and i <= #grid and j > 0 and j <= #grid[i]
end

local function count_paths_from(grid, distinct_trails, p, n, trailends)
  assert(grid[p.i][p.j] == n)
  if n == TRAILEND then
    insert_point(distinct_trails, trailends, p)
    return
  end
  local neighbours = {
    { i = p.i - 1, j = p.j + 0 },
    { i = p.i + 1, j = p.j + 0 },
    { i = p.i + 0, j = p.j - 1 },
    { i = p.i + 0, j = p.j + 1 },
  }
  local next = n + 1
  for _, q in ipairs(neighbours) do
    if in_bounds(grid, q.i, q.j) and grid[q.i][q.j] == next then
      count_paths_from(grid, distinct_trails, q, next, trailends)
    end
  end
end

local function go(grid, distinct_trails)
  local sum = 0
  for i = 1, #grid do
    for j = 1, #grid[i] do
      if grid[i][j] == TRAILHEAD then
        local trailends = {}
        count_paths_from(grid, distinct_trails, { i = i, j = j }, TRAILHEAD, trailends)
        sum = sum + #trailends
      end
    end
  end
  return sum
end

local function part1(filename)
  local lines = lib.load_lines_from_file(filename)
  return go(lines_to_grid(lines), false)
end

local function part2(filename)
  local lines = lib.load_lines_from_file(filename)
  return go(lines_to_grid(lines), true)
end

return {
  part1 = part1,
  part2 = part2,
}
