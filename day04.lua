local lib = require("lib")

local XMAS = "XMAS"

local function reverse(s)
  local t = ""
  for i = 1, #s do
    t = s:sub(i, i) .. t
  end
  return t
end

local function count_xmas(s)
  local c = 0
  for i = 1, #s - #XMAS + 1 do
    local t = s:sub(i, i + #XMAS - 1)
    if t == XMAS then
      c = c + 1
    end
  end
  return c
end

local function part1(filename)
  local lines = lib.load_lines_from_file(filename)
  local c = 0

  -- rows
  for _, s in ipairs(lines) do
    c = c + count_xmas(s) + count_xmas(reverse(s))
  end

  -- columns
  for col = 1, #lines[1] do
    local s = ""
    for r = 1, #lines do
      s = s .. lines[r]:sub(col, col)
    end
    c = c + count_xmas(s) + count_xmas(reverse(s))
  end

  -- top-left to bottom-right diagonals
  for r = 1, #lines - #XMAS + 1 do
    local line = lines[r]
    for i = 1, #line - #XMAS + 1 do
      local s = ""
      s = s .. line:sub(i, i)
      s = s .. lines[r + 1]:sub(i + 1, i + 1)
      s = s .. lines[r + 2]:sub(i + 2, i + 2)
      s = s .. lines[r + 3]:sub(i + 3, i + 3)
      assert(#s == #XMAS)
      if s == XMAS or reverse(s) == XMAS then
        c = c + 1
      end
    end
  end

  -- bottom-left to top-right diagonals
  for r = #lines, #XMAS, -1 do
    local line = lines[r]
    for i = 1, #line - #XMAS + 1 do
      local s = ""
      s = s .. line:sub(i, i)
      s = s .. lines[r - 1]:sub(i + 1, i + 1)
      s = s .. lines[r - 2]:sub(i + 2, i + 2)
      s = s .. lines[r - 3]:sub(i + 3, i + 3)
      assert(#s == #XMAS)
      if s == XMAS or reverse(s) == XMAS then
        c = c + 1
      end
    end
  end

  return c
end

local function part2(filename)
  local lines = lib.load_lines_from_file(filename)
  return -1
end

return {
  part1 = part1,
  part2 = part2,
}
