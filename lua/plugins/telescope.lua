return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				pickers = {
					theme = "ivy"
				},
				extensions = {
					fzf = {}
				}
			})

			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-n>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fc", function()
				local opts = require("telescope.themes").get_dropdown({
					cwd = vim.fn.stdpath("config")
				})
				builtin.find_files(opts)
			end)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			-- vim.keymap.set("n", "<leader>gr", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fp", function()
				builtin.find_files({
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
				})
			end)

			require("telescope.multigrep").setup()
		end,
	},
	--{
	--"nvim-telescope/telescope-ui-select.nvim",
	--config = function()
	--require("telescope").setup({
	--extensions = {
	--["ui-select"] = {
	--require("telescope.themes").get_dropdown({}),
	--},
	--},
	--})
	--require("telescope").load_extension("ui-select")
	--end,
	--},
}
