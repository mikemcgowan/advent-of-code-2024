local day = require("day06")

describe("day 6", function()
  it("works for part 1", function()
    assert.are.same(41, day.part1("./inputs/day06-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(6, day.part2("./inputs/day06-spec.txt"))
  end)
end)
