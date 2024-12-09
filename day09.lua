local lib = require("lib")

local FREE = "."

local function to_blocks(s)
  local t = {}
  local id = 0
  for i = 1, #s do
    local n = tonumber(s:sub(i, i))
    if i % 2 == 0 then
      for _ = 1, n do
        table.insert(t, FREE)
      end
    else
      for _ = 1, n do
        table.insert(t, id)
      end
      id = id + 1
    end
  end
  return t
end

local function count_free(t)
  local count = 0
  for _, v in ipairs(t) do
    if v == FREE then
      count = count + 1
    end
  end
  return count
end

local function index_of_first_free_block(t, from)
  for i = from, #t do
    if t[i] == FREE then
      return i
    end
  end
end

local function index_of_first_free_block_of_size(t, size)
  for i = 1, #t do
    if t[i] == FREE then
      local count = 1
      for j = 1, size - 1 do
        if t[i + j] == FREE then
          count = count + 1
        end
      end
      if count >= size then
        return i
      end
    end
  end
end

local function defragment_part_1(t)
  assert(t[#t] ~= FREE)
  local l = #t
  local blocks_moved = 0
  local blocks_to_move = count_free(t)
  local from = 1
  repeat
    local i = index_of_first_free_block(t, from)
    from = i
    local c = t[l - blocks_moved]
    t[i] = c
    t[l - blocks_moved] = FREE
    blocks_moved = blocks_moved + 1
  until blocks_moved >= blocks_to_move
  return t
end

local function defragment_part_2(t)
  assert(t[#t] ~= FREE)
  local start_id = t[#t]
  local i = #t
  for id = start_id, 0, -1 do
    while t[i] ~= id do
      i = i - 1
    end
    local size_required = 0
    while t[i] == id do
      size_required = size_required + 1
      i = i - 1
    end
    local j = index_of_first_free_block_of_size(t, size_required)
    if j and j < i then
      for k = 1, size_required do
        t[j + k - 1] = id
        t[i + k] = FREE
      end
    end
  end
  return t
end

local function checksum(t)
  local sum = 0
  for i, n in ipairs(t) do
    if n ~= FREE then
      sum = sum + (i - 1) * n
    end
  end
  return math.floor(sum)
end

local function part(filename, f)
  local lines = lib.load_lines_from_file(filename)
  local line = lines[1]
  local blocks = to_blocks(line)
  local defragmented = f(blocks)
  return checksum(defragmented)
end

local function part1(filename)
  return part(filename, defragment_part_1)
end

local function part2(filename)
  return part(filename, defragment_part_2)
end

return {
  part1 = part1,
  part2 = part2,
}
