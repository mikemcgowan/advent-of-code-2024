local day = require("day05")

describe("day 5", function()
  it("works for part 1", function()
    assert.are.same(143, day.part1("./inputs/day05-spec.txt"))
  end)

  it("works for part 2", function()
    assert.are.same(123, day.part2("./inputs/day05-spec.txt"))
  end)
end)
