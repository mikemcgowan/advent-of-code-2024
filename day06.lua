local lib = require("lib")

local GUARD = "^"
local OBSTACLE = "#"
local FLOOR = "."
local NORTH = "N"
local EAST = "E"
local SOUTH = "S"
local WEST = "W"
local COMPLETE = true
local STUCK = false

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

local function is_footprint(c)
  return c == NORTH or c == EAST or c == SOUTH or c == WEST
end

local function patrol(grid, start)
  local dir = NORTH
  local pos = { row = start.row, col = start.col }
  grid[pos.row][pos.col] = dir
  while true do
    local next_pos = move(dir, pos)
    if next_pos.row < 1 or next_pos.row > #grid or next_pos.col < 1 or next_pos.col > #grid[1] then
      return COMPLETE
    end
    if grid[next_pos.row][next_pos.col] == OBSTACLE then
      dir = turn_right(dir)
    else
      pos.row = next_pos.row
      pos.col = next_pos.col
      if is_footprint(grid[pos.row][pos.col]) and grid[pos.row][pos.col] == dir then
        return STUCK
      end
      grid[pos.row][pos.col] = dir
    end
  end
end

local function get_footprints(grid)
  local footprints = {}
  for i = 1, #grid do
    for j = 1, #grid[i] do
      if is_footprint(grid[i][j]) then
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
      if is_footprint(grid[i][j]) then
        c = c + 1
      end
    end
  end
  return c
end

local function clean_footprints(grid)
  for _, f in ipairs(get_footprints(grid)) do
    grid[f.row][f.col] = FLOOR
  end
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
  local count = 0
  local footprints = get_footprints(grid)
  for i, f in ipairs(footprints) do
    if i % 1000 == 0 then
      print((i .. " of " .. #footprints):add_colour(lib.colours.green))
    end
    clean_footprints(grid)
    grid[f.row][f.col] = OBSTACLE
    if patrol(grid, start) == STUCK then
      count = count + 1
    end
    grid[f.row][f.col] = FLOOR
  end
  return count
end

return {
  part1 = part1,
  part2 = part2,
}
