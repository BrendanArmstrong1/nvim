local M1 = { "BrendanArmstrong1/sortvis.nvim", cmd = "SortVis", config = true }
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

return { M1, M2, M3 }
