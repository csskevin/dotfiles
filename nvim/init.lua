

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Numbering
vim.opt.number = true

-- Mouse
vim.opt.mouse = "a"

-- 2 tabs or heuristic
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Set terminal interface
vim.go.termguicolors = true
vim.go.background = "dark"
vim.g.have_nerd_font = false

-- nvim-cmp limits
vim.go.pumheight = 7
vim.go.pumwidth = 7

vim.opt.scrolloff = 10

vim.opt.showmode = false

-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.hlsearch = true

-------------
-- Theming --
-------------
-- vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
-- 	group = vim.api.nvim_create_augroup("Color", {}),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "Search", { bg = "#ffb700", fg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "NonText", { bg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "#000000", fg = "#ffffff" })
-- 		vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000", fg = "#5a5a5a" })
-- 		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#000000", fg = "#ffb700" })
-- 		vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", fg = "#ffffff" })
-- 		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#ffb700", fg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "PmenuSbar", { fg = "#ffb700", bg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "PmenuThumb", { fg = "#ffb700", bg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#252526" })
-- 		vim.api.nvim_set_hl(0, "Cursor", { bg = "#ffb700", fg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "TermCursor", { bg = "#ffb700", fg = "#000000" })
-- 		vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "#515151", fg = "#ffffff" })
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
-- 	end,
-- })
--
----------------------
-- File Autocommand --
----------------------
local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- C/C++ 81 cols
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("cpp"),
	pattern = { "cpp", "c", "h", "tpp", "cxx", "hpp" },
	callback = function()
		vim.opt_local.colorcolumn = "81"
	end,
})

-- MD/Org 81 cols
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("docs"),
	pattern = { "md", "org" },
	callback = function()
		vim.opt_local.colorcolumn = "81"
	end,
})

--------------
-- Mappings --
--------------

-- Fix search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save buffer
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")

--  Split navigation
vim.keymap.set("n", "<C-h>", "<C-PageUp>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-PageDown>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-c>", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<C-j>", ":NvimTreeToggle<CR>", { desc = "Toggles nvim tree" })

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
-------------
-- Plugins --
-------------

-- Install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy plugin list
require("lazy").setup({
  {
    "jose-elias-alvarez/null-ls.nvim"
  },
  {
    "nvim-pack/nvim-spectre"
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },
  {
  "karb94/neoscroll.nvim",
  config = function ()
    require('neoscroll').setup {}

    local t = {}
    t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '10'}}
    t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '10'}}
    t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '50'}}
    t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '50'}}
    t['<C-y>'] = {'scroll', {'-0.10', 'false', '10'}}
    t['<C-e>'] = {'scroll', { '0.10', 'false', '10'}}
    t['zt']    = {'zt', {'50'}}
    t['zz']    = {'zz', {'50'}}
    t['zb']    = {'zb', {'50'}}
    require('neoscroll.config').set_mappings(t)
  end
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
      -- optional for floating window border decoration
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
      -- setting the keybinding for LazyGit with 'keys' is recommended in
      -- order to load the plugin when the command is run for the first time
      keys = {
         { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
      }
  },
	{
		-- Heuristicaly detect tabstop/shiftwidth from file
		"tpope/vim-sleuth",
	},
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = true,
      current_line_blame = true,
      on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage Hunk" })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc= "Reset Hunk" })
          map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage Buffer" })
          map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset Buffer" })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview Hunk" })
          map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "Full Line Blame" })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle Blame Line" })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff This" })
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Diff This ~"})
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Toggle Deleted"})

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
  },
	{
		-- nvim statusline
		"nvim-lualine/lualine.nvim",
		opts = function()
			return {
				options = {
					icons_enabled = false,
					style = "default",
					theme = "material",
					section_separators = "",
					component_separators = "|"
        },
        sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch", "diff", "diagnostics" },
						lualine_c = {{ "filename", file_status = true, path = 3 }},
						lualine_x = { "encoding", "filetype" },
						lualine_z = { "location" },
				},
			}
		end,
	},

	{
		-- Comment visual region/line with "gc"
		"numToStr/Comment.nvim",
		opts = {},
	},

	{
		-- Autopairs
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		-- Show keybinds
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "[H]unks (Git)", _ = "which_key_ignore"}
			})
		end,
	},

	{
		-- Indentation guides
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},

	-- {
	-- 	-- Base colorscheme
	-- 	"Mofiqul/vscode.nvim",
	-- 	-- Load this before any other plugin
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("vscode")
	-- 	end,
	-- },
  {
      'AlexvZyl/nordic.nvim',
      lazy = false,
      priority = 1000,
      config = function()
          require 'nordic' .load()
      end
  },
	{
		-- Fuzzy Finder
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",

				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Icons in telescope
			--{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				-- Telescope mappings
				defaults = {
					mappings = {
						i = {
							["<Esc>"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-b>"] = actions.preview_scrolling_up,
						},
						n = {
							["<Esc>"] = actions.close,
							["q"] = actions.close,
						},
					},
          winblend = 30
				},
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

      -- Telescope rewrite path display
      require('telescope').setup {
        defaults = {
            path_display = function(_, path)
                local tail = require("telescope.utils").path_tail(path)
                return string.format("%s (%s)", tail, path)
            end,
        },
      }

			-- Telescope triggering mappings (move outside)
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{
		-- LSP
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			-- LSP handlers
      vim.lsp.set_log_level("off")
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = nil })
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = true,
					underline = true,
				})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- LSP mappings

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gd", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				clangd = {},
				cmakelang = {},
				cpplint = {},
				cpptools = {},
				-- gopls = {},
				pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--

        typst_lsp = {
          settings = {
            exportPdf = "never"
          }
        },
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers above are installed
			require("mason").setup()
			-- add other tools for Mason to install
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- { -- Autoformat
	-- 	"stevearc/conform.nvim",
	-- 	lazy = false,
	-- 	keys = {
	-- 		{
	-- 			"<leader>f",
	-- 			function()
	-- 				require("conform").format({ async = true, lsp_fallback = true })
	-- 			end,
	-- 			mode = "",
	-- 			desc = "[F]ormat buffer",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		notify_on_error = false,
	-- 		format_on_save = function(bufnr)
	-- 			-- Disable "format_on_save lsp_fallback" for languages that don't
	-- 			-- have a well standardized coding style. You can add additional
	-- 			-- languages here or re-enable it for the disabled ones.
	-- 			local disable_filetypes = { c = true, cpp = true }
	-- 			return {
	-- 				timeout_ms = 500,
	-- 				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
	-- 			}
	-- 		end,
	-- 		formatters_by_ft = {
	-- 			lua = { "stylua" },
	-- 			-- Conform can also run multiple formatters sequentially
	-- 			-- python = { "isort", "black" },
	-- 			--
	-- 			-- You can use a sub-list to tell conform to run *until* a formatter
	-- 			-- is found.
	-- 			-- javascript = { { "prettierd", "prettier" } },
	-- 		},
	-- 	},
	-- },

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					max_width = 15,
					fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind },
					format = function(entry, vim_item)
						vim_item.menu = ""
						vim_item.abbr = string.sub(vim_item.abbr, 1, 15)
						return vim_item
					end,
				},
				window = {
					completion = {
						scrolloff = 1,
						completeopt = "menu,menuone,noinsert",
            side_padding = 0,
						border = "rounded",
						scrollbar = false,
						max_width = 10,
						max_height = 5,
					},
					documentation = {
						border = "rounded",
						scrollbar = false,
					},
				},

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-j>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-k>"] = cmp.mapping.select_prev_item(),

					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-l>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "bash", "c", "cpp", "python", "lua", "luadoc", "markdown", "vim", "vimdoc" },
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},

	-- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
