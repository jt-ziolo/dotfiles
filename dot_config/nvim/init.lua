-- See here for how to get Ctrl+Shift+... bindings to work:
-- https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/

-- Early setup
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Installs
require("lazy").setup({
	-- Not sure if properly set up yet
	--"onsails/lspkind-nvim", -- LSP
	"windwp/nvim-ts-autotag",
	-- Definitely working
	"andymass/vim-matchup",
	"dcampos/cmp-snippy",
	"dcampos/nvim-snippy",
	"derektata/lorem.nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp", -- LSP
	"hrsh7th/nvim-cmp",
	"jose-elias-alvarez/null-ls.nvim", -- LSP
	"lewis6991/gitsigns.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"navarasu/onedark.nvim",
	"neovim/nvim-lspconfig", -- LSP
	"norcalli/nvim-colorizer.lua",
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"sbdchd/neoformat",
	"tpope/vim-eunuch",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"williamboman/mason-lspconfig.nvim", -- LSP
	-- Remaining entries are marked individually if I am not
	-- sure that they are working yet
	{
		"laytan/tailwind-sorter.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
		},
		build = "cd formatter && npm i && npm run build",
		config = true,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		"virchau13/tree-sitter-astro",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"folke/zen-mode.nvim",
		opts = {},
	},
	{
		"jay-babu/mason-null-ls.nvim", -- LSP
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	{
		"williamboman/mason.nvim", -- LSP
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	},
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
	},
	{ -- Not sure if fully functional
		"chrisgrieser/nvim-various-textobjs",
		opts = { useDefaultKeymaps = true },
	},
	{ -- Not sure if fully functional
		"bennypowers/nvim-regexplainer",
		config = function()
			require("regexplainer").setup({})
		end,
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter", -- LSPish
		build = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				-- https://www.reddit.com/r/neovim/comments/r22xrq/comment/hm2dv20/
				layout_strategy = "vertical",
				layout_config = {
					height = 0.95,
					-- preview_width = 0.65,
					-- https://www.reddit.com/r/neovim/comments/yrqm9f/comment/ivv8hoa/
					-- width = function(_, cols, _)
					--   if cols > 200 then
					--     return 170
					--   else
					--     return math.floor(cols * 0.87)
					--   end
					-- end,
				},
			},
		},
	},
})

-- Setup
require("nvim-treesitter.configs").setup({
	ensure_installed = { "astro", "tsx", "typescript", "html" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})
---- nvim-tree: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
---- nvim-tree: set termguicolors to enable highlight groups
vim.opt.termguicolors = true
---- Stop diagnostics from appearing on the same line as virtual text
vim.diagnostic.config({ virtual_text = false })
require("lorem").setup({
	sentenceLength = "mixed",
	comma = 0.3,
})
require("gitsigns").setup()
require("fidget").setup()
local hop = require("hop")
require("Comment").setup()
require("nvim-ts-autotag").setup()
require("onedark").load()
require("colorizer").setup()
require("nvim-tree").setup() -- default setup
require("bufferline").setup({})
---- LuaLine StatusBar
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
---- snippy setup
require("snippy").setup({
	mappings = {
		is = {
			["<Tab>"] = "expand_or_advance",
			["<S-Tab>"] = "previous",
		},
		--nx = {
		--["<leader>x"] = "cut_text",
		--},
	},
})
---- cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			require("snippy").expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
		-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<M-c>"] = cmp.mapping.abort(),
		["<C-e>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = "vsnip" }, -- For vsnip users.
		-- { name = "luasnip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		{ name = "snippy" }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})
---- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources( --{
		-- { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		-- }, {
		{
			{ name = "buffer" },
		}
	),
})
---- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
---- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
---- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
---- LspKind suggestions
--[[ local lspkind = require("lspkind")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			-- before = function (entry, vim_item)
			-- return vim_item
			-- end
		}),
	},
}) ]]
---- Mason and null-ls
require("null-ls").setup()
require("mason").setup()
require("mason-null-ls").setup({
	handlers = {},
})
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["rust_analyzer"] = function ()
	-- require("rust-tools").setup {}
	-- end
})
---- various-textobjs
vim.keymap.set("n", "dsi", function()
	-- select inner indentation
	require("various-textobjs").indentation(true, true)
	-- plugin only switches to visual mode when a textobj has been found
	local notOnIndentedLine = vim.fn.mode():find("V") == nil
	if notOnIndentedLine then
		return
	end
	-- dedent indentation
	vim.cmd.normal({ "<", bang = true })
	-- delete surrounding lines
	local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
	local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
	vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
	vim.cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete surrounding indentation" })

-- Keybinds
-- Allows sorting while in visual mode (:s... cancels visual selection)
vim.keymap.set("v", "<leader>s", ":sort<CR>", { noremap = true, silent = true })
---- System Yank
vim.keymap.set({ "n", "o", "x" }, "<leader>y", '"+y', { desc = "SystemYank" })
---- Center search results
vim.keymap.set("n", "n", "nzz", {})
vim.keymap.set("n", "N", "Nzz", {})
---- Buffer
vim.keymap.set("n", "<c-i>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>xx", "<cmd>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>xo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
---- Format
vim.keymap.set("n", "<C-f>", "<cmd>Neoformat<CR>", { desc = "Neoformat" })
---- Spider (subword navigation)
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
---- Todo comments
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
---- Hop (like EasyMotion)
hop.setup({})
vim.keymap.set("", "<leader>/", "<cmd>lua require('hop').hint_patterns()<CR>", { desc = "HopPattern" })
vim.keymap.set("", "<leader>j", "<cmd>lua require('hop').hint_vertical()<CR>", { desc = "HopLineDown" })
vim.keymap.set("", "<leader>k", "<cmd>lua require('hop').hint_vertical()<CR>", { desc = "HopLineUp" })
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true, desc = "HopFindForward" })
vim.keymap.set("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, desc = "HopFindBackward" })
vim.keymap.set("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, desc = "HopTilForward" })
vim.keymap.set("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, desc = "HopTilBackward" })
---- Telescope keybinds
local builtin = require("telescope.builtin")
---- More potential keybinds can be found on the telescope github page
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "TS find files" })
vim.keymap.set("n", "<leader>c", builtin.commands, { desc = "TS cmds" })
vim.keymap.set("n", "<leader>f", builtin.jumplist, { desc = "TS jumps" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "TS definition" })
vim.keymap.set("n", "<leader>of", builtin.oldfiles, { desc = "TS old files" })
vim.keymap.set("n", "<leader>m", builtin.marks, { desc = "TS marks" })
vim.keymap.set("n", "<leader>reg", builtin.registers, { desc = "TS registers" })
vim.keymap.set("n", "<leader>?", builtin.keymaps, { desc = "TS keymaps" })
vim.keymap.set("n", "<leader>ref", builtin.lsp_references, { desc = "TS LSP references" })
vim.keymap.set("n", "<leader>i", builtin.lsp_implementations, { desc = "TS implementations" })
---- vim.keymap.set("n", "<leader>d", builtin.lsp_type_definitions, { desc = "TS LSP type definition" })
---- NvimTree keybinds
---- Use this mapping, and then use q to close the tree
vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeFocus<CR>", { desc = "Open/Focus NvimTree" })
---- Code Actions keybind
---- Ctrl+. is not possible, so I changed my VSCode binding to Ctrl+Shift+G
vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Show code actions" })
---- lspsaga keybinds
vim.keymap.set("n", "<leader>[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev diagnostic" })
vim.keymap.set("n", "<leader>]", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next diagnostic" })
---- various-textobjs
vim.keymap.set("n", "gx", function()
	-- select URL
	require("various-textobjs").url()
	-- plugin only switches to visual mode when textobj found
	local foundURL = vim.fn.mode():find("v")
	if not foundURL then
		return
	end
	-- retrieve URL with the z-register as intermediary
	vim.cmd.normal({ '"zy', bang = true })
	local url = vim.fn.getreg("z")
	-- open with the OS-specific shell command
	local opener
	if vim.fn.has("macunix") == 1 then
		opener = "open"
	elseif vim.fn.has("linux") == 1 then
		opener = "xdg-open"
	elseif vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
		opener = "start"
	end
	local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
	vim.fn.system(openCommand)
end, { desc = "URL Opener" })
---- indent_blankline
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})
