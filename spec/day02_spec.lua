local day = require("day02")

describe("day 2", function()
  it("works for part 1", function()
    assert.are.same(2, day.part1("./inputs/day02-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(4, day.part2("./inputs/day02-spec.txt"))
  end)
end)
