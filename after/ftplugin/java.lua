local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/jdtls/workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local capabilities = require("blink.cmp").get_lsp_capabilities()

local config = {
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens',
		'java.base/java.util=ALL-UNNAMED',
		'--add-opens',
		'java.base/java.lang=ALL-UNNAMED',
		'-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
		'-jar',
		vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
		'-configuration',
		home .. '/.local/share/nvim/mason/packagesig_linux',
		'-data',
		workspace_dir,
	},
	root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },

	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = 'all', -- literals, all, none
				},
			},
			format = {
				enabled = false,
			},
		},
	},

	init_options = {
		bundles = {},
	},
	capabilities = capabilities,
}

require("jdtls").start_or_attach(config)

vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

function format()
	require("jdtls").organize_imports()
	vim.lsp.buf.format()
end

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = format,
})

vim.keymap.set("n", "gf", format, {})
