local M1 = { "BrendanArmstrong1/visual_sort.nvim", cmd = "SortVis", config = true }
M1.dev = false

local M2 = { "BrendanArmstrong1/lua_snippet_repo.nvim" }
M2.dev = false

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

local M4 = { "BrendanArmstrong1/base_converter.nvim"}
M4.dev = false
M4.cmd = {"BCtohex"}
M4.config = true

local M5 = { "BrendanArmstrong1/visual_transpose.nvim" }
M5.dev = true
M5.cmd = {"VisTranspose"}
M5.config = true

return { M1, M2, M3, M4, M5 }
