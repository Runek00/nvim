return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>t", ":Neotree filesystem toggle right reveal<CR>")
		local ntree = require("neo-tree")
		ntree.setup({
			close_if_last_window = true,
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
			window = {
				mappings = {
					["P"] = {
						"toggle_preview",
						config = { use_float = true, use_image_nvim = true }
					},
				},
			},
		})
	end,
}
