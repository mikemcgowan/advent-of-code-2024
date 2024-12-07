local day = require("day07")

describe("day 7", function()
  it("works for part 1", function()
    assert.are.same(3749, day.part1("./inputs/day07-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(11387, day.part2("./inputs/day07-spec.txt"))
  end)
end)
