vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

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

if vim.g.vscode then
	-------------------------------------------------------------------
	-- The following applies ONLY for VSCode
	-- Everything under require("lazy") will be a subset of what is
	-- included in the settings for ordinary NeoVim
	-------------------------------------------------------------------

	require("lazy").setup({
		-- Not sure I need these yet
		-- ...

		-- Not sure if properly set up yet
		-- ...

		-- Definitely working
		"phaazon/hop.nvim",
		"derektata/lorem.nvim",
		"tpope/vim-surround",
		"tpope/vim-repeat",
		"numToStr/Comment.nvim",

		-- Remaining entries are marked individually if I am not
		-- sure that they are working yet
		{
			"chrisgrieser/nvim-spider",
			lazy = true,
		},
		{ -- Not sure if fully functional
			"chrisgrieser/nvim-various-textobjs",
			opts = { useDefaultKeymaps = true },
		},
		{ -- Not sure of full scope of functionality vs. nvim-various-textobjs
			"echasnovski/mini.nvim",
			version = false,
		},
	})
else
	-------------------------------------------------------------------
	-- The following applies ONLY for ordinary Neovim outside of VSCode
	-------------------------------------------------------------------

	require("lazy").setup({
		-- Not sure I need these yet
		-- ...

		-- Not sure if properly set up yet
		"onsails/lspkind-nvim", -- LSP
		"windwp/nvim-ts-autotag",

		-- Definitely working
		"hrsh7th/cmp-nvim-lsp", -- LSP
		"sbdchd/neoformat",
		"tpope/vim-eunuch",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"williamboman/mason-lspconfig.nvim", -- LSP
		"neovim/nvim-lspconfig", -- LSP
		"jose-elias-alvarez/null-ls.nvim", -- LSP
		"nvim-tree/nvim-web-devicons",
		"nvim-tree/nvim-tree.lua",
		"andymass/vim-matchup",
		"phaazon/hop.nvim",
		"derektata/lorem.nvim",
		"norcalli/nvim-colorizer.lua",
		"tpope/vim-surround",
		"tpope/vim-repeat",
		"navarasu/onedark.nvim",
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"numToStr/Comment.nvim",

		-- Remaining entries are marked individually if I am not
		-- sure that they are working yet
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
		{ -- Not sure of full scope of functionality vs. nvim-various-textobjs
			"echasnovski/mini.nvim",
			version = false,
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

	-- nvim-tree: disable netrw at the very start of your init.lua
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- nvim-tree: set termguicolors to enable highlight groups
	vim.opt.termguicolors = true

	-- Stop diagnostics from appearing on the same line as virtual text
	vim.diagnostic.config({ virtual_text = false })

	-- Requires
	-----------

	-- Simple
	require("nvim-ts-autotag").setup()
	require("onedark").load()
	require("colorizer").setup()
	require("nvim-tree").setup() -- default setup
	vim.opt.termguicolors = true
	require("bufferline").setup({})

	-- LuaLine StatusBar
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

	-- snippy setup
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

	-- cmp setup
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
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-c>"] = cmp.mapping.abort(),
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
	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources( --{
			-- { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			-- }, {
			{
				{ name = "buffer" },
			}
		),
	})
	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
	-- Set up lspconfig.
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	-- require("lspconfig")["cssls"].setup({
	-- capabilities = capabilities,
	-- })

	-- LspKind suggestions
	local lspkind = require("lspkind")
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
	})

	-- Mason and null-ls
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

	-- Keybinds
	-----------

	-- Format
	-- See here for how to get Ctrl+Shift+... bindings to work:
	-- https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
	vim.keymap.set("n", "<C-S-i>", "<cmd>Neoformat<CR>", { desc = "Neoformat" })

	-- Buffer
	vim.keymap.set("n", "<c-i>", "<cmd>bnext<CR>", { desc = "Next buffer" })

	-- Telescope keybinds
	local builtin = require("telescope.builtin")
	-- More potential keybinds can be found on the telescope github page
	vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "TS find files" })
	-- See here for how to get Ctrl+Shift+... bindings to work:
	-- https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
	vim.keymap.set("n", "<C-S-p>", builtin.commands, { desc = "TS cmds" })
	vim.keymap.set("n", "<C-S-o>", builtin.jumplist, { desc = "TS jumps" })
	vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "TS definition" })
	vim.keymap.set("n", "<leader><S-f>", builtin.oldfiles, { desc = "TS old files" })
	vim.keymap.set("n", "<leader>`", builtin.marks, { desc = "TS marks" })
	vim.keymap.set("n", "<leader>'", builtin.registers, { desc = "TS registers" })
	vim.keymap.set("n", "<leader>?", builtin.keymaps, { desc = "TS keymaps" })
	vim.keymap.set("n", "<leader>r", builtin.lsp_references, { desc = "TS LSP references" })
	vim.keymap.set("n", "<leader>i", builtin.lsp_implementations, { desc = "TS implementations" })
	-- vim.keymap.set("n", "<leader>d", builtin.lsp_type_definitions, { desc = "TS LSP type definition" })

	-- NvimTree keybinds
	vim.keymap.set("n", "<C-S-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

	-- Code Actions keybind
	-- Ctrl+. is not possible, so I changed my VSCode binding to Ctrl+Shift+G
	-- See here for how to get Ctrl+Shift+... bindings to work:
	-- https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/
	vim.keymap.set("n", "<C-S-g>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Show code actions" })

	-- lspsaga keybinds
	vim.keymap.set("n", "<leader>[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev diagnostic" })
	vim.keymap.set("n", "<leader>]", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next diagnostic" })
end

-------------------------------------------------------------------
-- The following applies for both VSCode and ordinary Neovim
-- Note that we cannot call require("lazy").setup here,
-- so load your plugins in the prior two sections
-------------------------------------------------------------------

-- Requires
-----------

-- Simple
require("hop").setup({})
require("mini.ai").setup({})
require("lorem").setup({
	sentenceLength = "mixed",
	comma = 0.3,
})
require("Comment").setup()

-- Keybinds
-----------

-- Overwrites
-- Center search results
vim.keymap.set("n", "n", "nzz", {})
vim.keymap.set("n", "N", "Nzz", {})

-- Non-plugin keybinds
vim.keymap.set({ "n", "o", "x" }, "<leader>y", '"+y', { desc = "SystemYank" })

-- Other plugin keybinds
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
vim.keymap.set("", "<leader>/", "<cmd>lua require('hop').hint_patterns()<CR>", { desc = "HopPattern" })
vim.keymap.set("", "<leader>j", "<cmd>lua require('hop').hint_lines_skip_whitespace()<CR>", { desc = "HopLineDown" })
vim.keymap.set("", "<leader>k", "<cmd>lua require('hop').hint_lines_skip_whitespace()<CR>", { desc = "HopLineUp" })

-- My own plugins or keybinds
-- vim.keymap.set({"n"}, "<leader>a", "<cmd>lua require('nvim-bullseye').startAppendAfterWord()<CR>", { desc = "BullseyeStartAppendAfterWord" })
-- vim.keymap.set({"n"}, "<leader>i", "<cmd>lua require('nvim-bullseye').startInsertBeforeWord()<CR>", { desc = "BullseyeStartInsertBeforeWord" })
-- vim.keymap.set({"n"}, "<leader>P", "<cmd>lua require('nvim-bullseye').pasteBeforeN()<CR>", { desc = "BullseyePasteBeforeN" })
-- vim.keymap.set({"n"}, "<leader>p", "<cmd>lua require('nvim-bullseye').pasteAfterN()<CR>", { desc = "BullseyePasteAfterN" })
