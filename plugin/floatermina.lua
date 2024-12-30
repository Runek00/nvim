local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_terminal(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Position
	local row = math.ceil((vim.o.lines - height) / 2)
	local col = math.ceil((vim.o.columns - width) / 2)

	-- Buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Window config
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Create window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_terminal({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.edit("term://tmux")
		end
	else
		vim.api.nvim_win_close(state.floating.win, true)
	end
	print(vim.inspect(state.floating))
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set("n", "<leader>ft", toggle_terminal)
