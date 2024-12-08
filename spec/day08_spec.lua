local day = require("day08")

describe("day 8", function()
  it("works for part 1", function()
    assert.are.same(14, day.part1("./inputs/day08-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(34, day.part2("./inputs/day08-spec.txt"))
  end)
end)
