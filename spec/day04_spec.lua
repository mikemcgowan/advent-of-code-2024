local day = require("day04")

describe("day 4", function()
  it("works for part 1", function()
    assert.are.same(18, day.part1("./inputs/day04-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(0, day.part2("./inputs/day04-spec.txt"))
  end)
end)
