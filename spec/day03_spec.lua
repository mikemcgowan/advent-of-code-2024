local day = require("day03")

describe("day 3", function()
  it("works for part 1", function()
    assert.are.same(161, day.part1("./inputs/day03-part1-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(48, day.part2("./inputs/day03-part2-spec.txt"))
  end)
end)
