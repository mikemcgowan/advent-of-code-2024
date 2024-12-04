local lib = require("lib")

local XMAS = "XMAS"
local A = "A"
local M = "M"
local S = "S"

local function reverse(s)
  local t = ""
  for i = 1, #s do
    t = s:sub(i, i) .. t
  end
  return t
end

local function count_xmas(s)
  local count = 0
  for i = 1, #s - #XMAS + 1 do
    local t = s:sub(i, i + #XMAS - 1)
    if t == XMAS then
      count = count + 1
    end
  end
  return count
end

local function find_xmas_on_diagonal(lines, row, col, downwards)
  local s = ""
  local x = downwards and 1 or -1
  for i = 0, #XMAS - 1 do
    s = s .. lines[row + x * i]:sub(col + i, col + i)
  end
  assert(#s == #XMAS)
  return s == XMAS or reverse(s) == XMAS
end

local function part1(filename)
  local lines = lib.load_lines_from_file(filename)
  local count = 0

  -- rows
  for _, s in ipairs(lines) do
    count = count + count_xmas(s) + count_xmas(reverse(s))
  end

  -- columns
  for col = 1, #lines[1] do
    local s = ""
    for r = 1, #lines do
      s = s .. lines[r]:sub(col, col)
    end
    count = count + count_xmas(s) + count_xmas(reverse(s))
  end

  -- top-left to bottom-right diagonals
  for r = 1, #lines - #XMAS + 1 do
    local line = lines[r]
    for c = 1, #line - #XMAS + 1 do
      if find_xmas_on_diagonal(lines, r, c, true) then
        count = count + 1
      end
    end
  end

  -- bottom-left to top-right diagonals
  for r = #lines, #XMAS, -1 do
    local line = lines[r]
    for c = 1, #line - #XMAS + 1 do
      if find_xmas_on_diagonal(lines, r, c, false) then
        count = count + 1
      end
    end
  end

  return count
end

local function is_MxS_or_SxM(c1, c2)
  return c1 == M and c2 == S or c1 == S and c2 == M
end

local function find_mas(lines, row, col)
  if lines[row]:sub(col, col) == A then
    local c1 = lines[row - 1]:sub(col - 1, col - 1)
    local c2 = lines[row + 1]:sub(col + 1, col + 1)
    if is_MxS_or_SxM(c1, c2) then
      c1 = lines[row - 1]:sub(col + 1, col + 1)
      c2 = lines[row + 1]:sub(col - 1, col - 1)
      if is_MxS_or_SxM(c1, c2) then
        return true
      end
    end
  end
  return false
end

local function part2(filename)
  local lines = lib.load_lines_from_file(filename)
  local count = 0
  for row = 2, #lines - 1 do
    for col = 2, #lines[1] - 1 do
      if find_mas(lines, row, col) then
        count = count + 1
      end
    end
  end
  return count
end

return {
  part1 = part1,
  part2 = part2,
}
