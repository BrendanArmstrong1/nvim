return {
	{
		"BrendanArmstrong1/sortvis.nvim",
		cmd = "SortVis",
		dev = false,
		config = true,
	},
	{
		"BrendanArmstrong1/visual_replace.nvim",
		keys = {
			{
				"<leader>s",
				function()
					require("visual_replace").replace_visual()
				end,
				mode = "x",
			},
		},
		dev = false,
	},
}
