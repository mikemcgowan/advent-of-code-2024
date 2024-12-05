local lib = require("lib")

local MATCH_COMMA = "([^,]+)"
local MATCH_PIPE = "([^|]+)"

local function in_array(t, v)
  for _, w in ipairs(t) do
    if v == w then
      return true
    end
  end
  return false
end

local function all(t, f)
  for _, v in ipairs(t) do
    if not f(v) then
      return false
    end
  end
  return true
end

local function any(t, f)
  for _, v in ipairs(t) do
    if f(v) then
      return true
    end
  end
  return false
end

local function parse(lines)
  local first_section = true
  local rules = {}
  local updates = {}
  for _, line in ipairs(lines) do
    if #line == 0 then
      first_section = false
    else
      if first_section then
        local bits = line:split(MATCH_PIPE)
        local page = tonumber(bits[1])
        if page then
          local print_before_page = tonumber(bits[2])
          if not rules[page] then
            rules[page] = { print_before_page }
          else
            table.insert(rules[page], print_before_page)
          end
        end
      else
        local bits = line:split(MATCH_COMMA)
        table.insert(
          updates,
          lib.map(bits, function(x)
            return tonumber(x)
          end)
        )
      end
    end
  end
  return rules, updates
end

local function update_correct(rules, update)
  for i, page in ipairs(update) do
    local before = {}
    for j = 1, i - 1 do
      table.insert(before, update[j])
    end
    if rules[page] and any(before, function(x)
      return in_array(rules[page], x)
    end) then
      return false
    end

    local after = {}
    for j = i + 1, #update do
      table.insert(after, update[j])
    end
    if rules[page] and not all(after, function(x)
      return in_array(rules[page], x)
    end) then
      return false
    end
  end
  return true
end

local function reorder(rules, update)
  table.sort(update, function(a, b)
    return rules[a] and in_array(rules[a], b)
  end)
end

local function part1(filename)
  local lines = lib.load_lines_from_file(filename)
  local rules, updates = parse(lines)
  local correct_updates = lib.filter(updates, function(update)
    return update_correct(rules, update)
  end)
  local sum = 0
  for _, update in ipairs(correct_updates) do
    local n = #update
    sum = sum + update[n // 2 + 1]
  end
  return sum
end

local function part2(filename)
  local lines = lib.load_lines_from_file(filename)
  local rules, updates = parse(lines)
  local incorrect_updates = lib.filter(updates, function(update)
    return not update_correct(rules, update)
  end)
  local sum = 0
  for _, update in ipairs(incorrect_updates) do
    reorder(rules, update)
    local n = #update
    sum = sum + update[n // 2 + 1]
  end
  return sum
end

return {
  part1 = part1,
  part2 = part2,
}
