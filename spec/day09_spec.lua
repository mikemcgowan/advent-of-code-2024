local day = require("day09")

describe("day 9", function()
  it("works for part 1", function()
    assert.are.same(1928, day.part1("./inputs/day09-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(2858, day.part2("./inputs/day09-spec.txt"))
  end)
end)
