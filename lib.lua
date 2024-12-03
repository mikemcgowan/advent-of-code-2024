local colours = {
  reset = "\27[0m",
  bold = "\27[1m",
  green = "\27[32m",
  yellow = "\27[33m",
  cyan = "\27[36m",
}

function string.add_colour(s, colour)
  local t = colours.bold
  if colour then
    t = t .. colour
  end
  t = t .. s .. colours.reset
  return t
end

function string.split(s, expr)
  expr = expr or "%S+"
  local t = {}
  for match in s:gmatch(expr) do
    table.insert(t, match)
  end
  return t
end

function string.to_lines(s)
  return s:split("[^\r\n]+")
end

local function load_lines_from_file(filename)
  local file = io.open(filename, "r")
  if not file then
    print(("Could not open file '" .. filename .. "'"):add_colour(colours.yellow))
    os.exit(1)
  end
  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()
  return lines
end

local function map(t, f)
  local u = {}
  for _, v in ipairs(t) do
    table.insert(u, f(v))
  end
  return u
end

local function filter(t, p)
  local u = {}
  for _, v in ipairs(t) do
    if p(v) then
      table.insert(u, v)
    end
  end
  return u
end

local function max_by(t, f)
  local max = nil
  local max_value = nil
  for _, v in ipairs(t) do
    if not max_value or f(v) > max_value then
      max_value = f(v)
      max = v
    end
  end
  return max
end

return {
  colours = colours,
  load_lines_from_file = load_lines_from_file,
  map = map,
  filter = filter,
  max_by = max_by,
}
