local M1 = { "BrendanArmstrong1/visual_sort.nvim" }
M1.cmd = "SortVis"
M1.dev = false
M1.config = true

local M2 = { "BrendanArmstrong1/converter.nvim" }
M2.keys = {"gt"}
M2.dev = false
M2.opts = {prefix = "gt"}

local M3 = { "BrendanArmstrong1/visual_replace.nvim" }
M3.dev = false

M3.keys = {
	{
		"<leader>s",
		function()
			require("visual_replace").replace_visual()
		end,
		mode = "x",
	},
}

-- local M4 = { "BrendanArmstrong1/visual_transpose.nvim" }
-- M4.cmd = "VisTranspose"
-- M4.dev = true
-- M4.config = true

-- return { M1, M2, M3, M4 }
return { M1, M2, M3 }
