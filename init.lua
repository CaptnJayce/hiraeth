vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
		end,
	},

	{
		{
			"RRethy/base16-nvim",
			lazy = false,
			config = function()
				vim.cmd("colorscheme base16-default-dark")
			end,
		},
	},

	{
		"Saghen/blink.cmp",
		version = "*",
		opts = {
			keymap = { preset = "super-tab" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "buffer" },
			},
			completion = {
				documentation = { auto_show = true },
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({})
		end,
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
					"ruff",
					"clangd",
					"neocmake",
					"bashls",
				},
				automatic_installation = true,
				handlers = {
					function(server_name)
						local capabilities = require("blink.cmp").get_lsp_capabilities()
						require("lspconfig")[server_name].setup({ capabilities = capabilities })
					end,
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					html = { "prettier" },
					css = { "prettier" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					python = { "ruff_format" },
					cpp = { "clang_format" },
					c = { "clang_format" },
					cmake = { "cmake_format" },
					lua = { "stylua" },
					sh = { "shfmt" },
				},
				format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
			})
		end,
	},

	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		event = "VeryLazy",
		opts = {},
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},
}, {
	ui = { border = "rounded" },
})

vim.keymap.set("n", "<leader>e", vim.cmd.Explore, { desc = "Open netrw" })
vim.keymap.set("n", "<leader>y", "<cmd>term yazi<<cr>", { desc = "Open yazi" })

local function set_transparent()
	local groups = {
		"Normal",
		"NormalNC",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"VertSplit",
		"WinSeparator",
		"EndOfBuffer",
		"LineNr",
		"CursorLineNr",
		"Folded",
		"FoldColumn",
		"TelescopeNormal",
		"TelescopeBorder",
		"WhichKeyFloat",
		"LazyNormal",
		"MasonNormal",
	}
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_transparent,
})

set_transparent()
