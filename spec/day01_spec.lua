local day = require("day01")

describe("day 1", function()
  it("works for part 1", function()
    assert.are.same(11, day.part1("./inputs/day01-test.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(31, day.part2("./inputs/day01-test.txt"))
  end)
end)
