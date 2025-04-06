local colors_name = "zen"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require("lush")
local hsl = lush.hsluv -- Human-friendly hsl
local util = require("zenbones.util")

local bg = vim.o.background

local p
p = util.palette_extend({
  bg = hsl("#121212"),
  fg = hsl("#bbbbbb"),
  sky = hsl("#2275c3"),
  rose = hsl("#b3004b"),
  dawn = hsl("#d87900"),
  violet = hsl("#c143ff"),
  blossom = hsl("#d3869b"),
  purple = hsl("#a548ff"),
}, bg)

-- Generate the lush specs using the generator util
local generator = require("zenbones.specs")
local base_specs = generator.generate(p, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
  return {
    ColorColumn({ bg = p.bg.lightness(p.bg.l + 15) }),

    -- Constant({ base_specs.Constant, fg = p.purple.da(30) }),
    String({ fg = p.sky }),
    -- Number({ fg = p.rose }),
    Boolean({ base_specs.Boolean, fg = p.dawn }),
  }
end)

-- Pass the specs to lush to apply
lush(specs)
