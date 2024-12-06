local lib = require("lib")

local GUARD = "^"
local OBSTACLE = "#"
local FOOTPRINT = "8"
local NORTH = "N"
local EAST = "E"
local SOUTH = "S"
local WEST = "W"

local function lines_to_grid(lines)
  local grid = {}
  local start = {}
  for row, line in ipairs(lines) do
    local xs = {}
    for col = 1, #line do
      local c = line:sub(col, col)
      table.insert(xs, c)
      if c == GUARD then
        start.row = row
        start.col = col
      end
    end
    table.insert(grid, xs)
  end
  return grid, start
end

local function turn_right(dir)
  if dir == NORTH then
    return EAST
  elseif dir == EAST then
    return SOUTH
  elseif dir == SOUTH then
    return WEST
  elseif dir == WEST then
    return NORTH
  else
    error()
  end
end

local function move(dir, pos)
  if dir == NORTH then
    return { row = pos.row - 1, col = pos.col }
  elseif dir == EAST then
    return { row = pos.row, col = pos.col + 1 }
  elseif dir == SOUTH then
    return { row = pos.row + 1, col = pos.col }
  elseif dir == WEST then
    return { row = pos.row, col = pos.col - 1 }
  else
    error()
  end
end

local function get_dir_from_path(path, row, col)
  for _, p in ipairs(path) do
    if p.row == row and p.col == col then
      return p.dir
    end
  end
end

local function patrol(grid, start)
  local path = {}
  local dir = NORTH
  local pos = { row = start.row, col = start.col }
  table.insert(path, { dir = dir, row = start.row, col = start.col })
  grid[start.row][start.col] = FOOTPRINT
  while true do
    local next_pos = move(dir, pos)
    if next_pos.row < 1 or next_pos.row > #grid or next_pos.col < 1 or next_pos.col > #grid[1] then
      return false
    end
    if grid[next_pos.row][next_pos.col] == OBSTACLE then
      dir = turn_right(dir)
    else
      pos.row = next_pos.row
      pos.col = next_pos.col
      if grid[pos.row][pos.col] == FOOTPRINT and get_dir_from_path(path, pos.row, pos.col) == dir then
        return true
      end
      table.insert(path, { dir = dir, row = pos.row, col = pos.col })
      grid[pos.row][pos.col] = FOOTPRINT
    end
  end
end

local function get_footprints(grid)
  local footprints = {}
  for i = 1, #grid do
    for j = 1, #grid[i] do
      if grid[i][j] == FOOTPRINT then
        table.insert(footprints, { row = i, col = j })
      end
    end
  end
  return footprints
end

local function count_footprints(grid)
  local c = 0
  for i = 1, #grid do
    for j = 1, #grid[i] do
      if grid[i][j] == FOOTPRINT then
        c = c + 1
      end
    end
  end
  return c
end

local function part1(filename)
  local lines = lib.load_lines_from_file(filename)
  local grid, start = lines_to_grid(lines)
  patrol(grid, start)
  return count_footprints(grid)
end

local function part2(filename)
  local lines = lib.load_lines_from_file(filename)
  local grid, start = lines_to_grid(lines)
  patrol(grid, start)
  local footprints = get_footprints(grid)
  local count = 0
  for _, f in ipairs(footprints) do
    local g, _ = lines_to_grid(lines)
    g[f.row][f.col] = OBSTACLE
    if patrol(g, start) then
      count = count + 1
    end
  end
  return count
end

return {
  part1 = part1,
  part2 = part2,
}
