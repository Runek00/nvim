return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"html",
					"htmx",
					"pylsp",
					"gopls",
					"zls",
					"robotframework_ls",
					"jdtls",
				},
			})
		end,
	},

	{ "mfussenegger/nvim-jdtls" },

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.htmx.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.zls.setup({
				capabilities = capabilities,
			})
			lspconfig.sourcekit.setup({
				capabilities = capabilities,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", function()
				require("telescope.builtin").lsp_definitions()
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "gr", function()
				require("telescope.builtin").lsp_references()
			end, { noremap = true, silent = true })
			vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "gf", vim.lsp.buf.format, {})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					if client.supports_method("textDocument/formatting") then
						-- Format the current buffer on save
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({
									bufnr = args.buf,
									id = client.id,
								})
							end,
						})
						print("save to format")
					else
						print("no save to format")
					end
				end,
			})
		end,
	},
}
