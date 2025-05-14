vim.cmd.colorscheme('tokyonight')

-- vim.lsp.config("*", {
-- 	capabilities = vim.lsp.protocol.make_client_capabilities()
-- })

require('nvim-treesitter.configs').setup({
	highlight = { enable = true, },
	auto_install = true,
	ensure_installed = { 'lua', 'vim', 'vimdoc', 'json' },
})

require('which-key').setup({
	icons = {
		mappings = false,
		keys = {
			Space = 'Space',
			Esc = 'Esc',
			BS = 'Backspace',
			C = 'Ctrl-',
		}
	}
})

require('which-key').add({
	{ '<leader>f', group = 'Fuzzy Find' },
	{ '<leader>b', group = 'Buffer' },
})

require('mini.icons').setup({ style = 'glyph' })

require('mini.ai').setup({ n_lines = 500 })

require('mini.comment').setup({})

require('mini.surround').setup({})

require('mini.notify').setup({
	lsp_progress = { enable = false }
})

vim.notify = require('mini.notify').make_notify({})

require('mini.bufremove').setup({})

vim.keymap.set('n', '<leader>bc', '<cmd>lua pcall(MiniBufremove.delete)<cr>', { desc = 'Close buffer' })

local mini_files = require('mini.files')
mini_files.setup({})

vim.keymap.set('n', '<leader>e', function()
	if mini_files.close() then 
		return
	end

	mini_files.open()
end, { desc = 'File explorer' })

require('mini.pick').setup({})

vim.keymap.set('n', '<leader>?', '<cmd>Pick oldfiles<cr>', { desc = 'Search file history' })
vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', { desc = 'Search open files' })
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', { desc = 'Search all files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Search in project' })
vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic<cr>', { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>fs', '<cmd>Pick buf_lines<cr>', { desc = 'Buffer local search' })

local mini_statusline = require('mini.statusline')

local function statusline()
	local mode, mode_hl = mini_statusline.section_mode({ trunc_width = 120 })
	local diagnostics = mini_statusline.section_diagnostics({ trunc_width = 75 })
	local lsp = mini_statusline.section_lsp({ icon = 'LSP', trunc_width = 75 })
	local filename = mini_statusline.section_filename({ trunc_width = 140 })
	local percent = '%2p%%'
	local location = '%3l:%-2c'

	return mini_statusline.combine_groups({
		{ hl = mode_hl, strings = { mode }},
		{ hl = 'MiniStatuslineDevInfo', strings = { diagnostics, lsp }},
		'%<', -- Mark general trucate point
		{ hl = 'MiniStatuslineFilename', strings = { filename }},
		'%=', -- end left alignment
		{ hl = 'MiniStatuslineFilename', strings = { '%{&filetype}' }},
		{ hl = 'MiniStatuslineFileinfo', strings = { percent }},
		{ hl = mode_hl, strings = { location }},
	})
end

mini_statusline.setup({
	content = { active = statusline },
})

require('mini.extra').setup({})

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'grr', '<cmd>lua vim.lsp.buf.reference()<cr>', opts)
		vim.keymap.set('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
		vim.keymap.set('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
		vim.keymap.set({ 'i',  's' }, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

		-- customs 
		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set({'n', 'x' }, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	end,
})

require('mason').setup()
require('mason-lspconfig').setup {
	ensure_installed = { "lua_ls" }
}
