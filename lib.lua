local colours = {
  reset = "\27[0m",
  bold = "\27[1m",
  green = "\27[32m",
  yellow = "\27[33m",
  cyan = "\27[36m",
}

function string.add_colour(text, colour)
  local s = colours.bold
  if colour then
    s = s .. colour
  end
  s = s .. text .. colours.reset
  return s
end

function string.split(text, expr)
  local lines = {}
  for line in text:gmatch(expr) do
    table.insert(lines, line)
  end
  return lines
end

function string.to_lines(text)
  return text:split("[^\r\n]+")
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

local function split(s)
  local t = {}
  for str in s:gmatch("%S+") do
    table.insert(t, str)
  end
  return t
end

return {
  colours = colours,
  load_lines_from_file = load_lines_from_file,
  map = map,
  filter = filter,
  max_by = max_by,
  split = split,
}
