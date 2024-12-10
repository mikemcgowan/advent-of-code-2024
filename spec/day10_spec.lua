local day = require("day10")

describe("day 10", function()
  it("works for part 1", function()
    assert.are.same(36, day.part1("./inputs/day10-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(0, day.part2("./inputs/day10-spec.txt"))
  end)
end)
