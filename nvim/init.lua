-- Disable yank on delete
-- vim.keymap.set("n", "d", "\"_d")
-- vim.keymap.set("v", "d", "\"_d")
-- vim.keymap.set("n", "x", "\"_x")
-- vim.keymap.set("v", "x", "\"_x")
-- vim.keymap.set("n", "D", "\"_D")
-- vim.keymap.set("v", "D", "\"_D")
--
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
vim.opt.colorcolumn = "80"

-- Set terminal interface
-- vim.go.background = "dark"
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

-- vim.cmd.colorscheme("elflord")
-------------
-- Theming --
-------------
-- vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
--     group = vim.api.nvim_create_augroup("Color", {}),
--     pattern = "*",
--     callback = function()
--         vim.api.nvim_set_hl(0, "Search", { bg = "#ffb700", fg = "#000000" })
--         vim.api.nvim_set_hl(0, "NonText", { bg = "#000000" })
--         vim.api.nvim_set_hl(0, "Normal", { bg = "#000000", fg = "#ffffff" })
--         vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000", fg = "#5a5a5a" })
--         vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#000000", fg = "#ffb700" })
--         vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
--         vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000000" })
--         vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#000000" })
--         vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", fg = "#ffffff" })
--         vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#ffb700", fg = "#000000" })
--         vim.api.nvim_set_hl(0, "PmenuSbar", { fg = "#ffb700", bg = "#000000" })
--         vim.api.nvim_set_hl(0, "PmenuThumb", { fg = "#ffb700", bg = "#000000" })
--         vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#252526" })
--         vim.api.nvim_set_hl(0, "Cursor", { bg = "#ffb700", fg = "#000000" })
--         vim.api.nvim_set_hl(0, "TermCursor", { bg = "#ffb700", fg = "#000000" })
--         vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "#515151", fg = "#ffffff" })
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
--     end,
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
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
--
--
-- vim.keymap.set("n", "<C-c>", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<C-j>", ":NvimTreeToggle<CR>", { desc = "Toggles nvim tree" })

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "[F]ormat buffer with LSP" })

vim.keymap.set("n", "<leader>v", function()
  if vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config({ virtual_lines = false })
  else
    vim.diagnostic.config({ virtual_lines = true })
  end
end, { desc = "Toggles virtual lines" })

vim.keymap.set("n", "<C-S-j>", ":NvimTreeFindFile<CR>", { desc = "Shows current file in nvim tree" })

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>")
vim.keymap.set("n", "}", "<cmd>AerialNext<CR>")

-------------
-- Plugins --
-------------

-- Install lazy using modern vim.uv
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Lazy plugin list
require("lazy").setup({
  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '0.3.*',
    build = function() require 'typst-preview'.update() end,
    opts = {
      follow_cursor = true
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        view = {
          side = "right"
        }
      }
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

    neoscroll = require('neoscroll')
    local keymap = {
      ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 10}) end;
      ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 10}) end;
      ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 50 }) end;
      ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 50 }) end;
      ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 10 }) end;
      ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 10 }) end;
      ["zt"]    = function() neoscroll.zt({ half_win_duration = 50 }) end;
      ["zz"]    = function() neoscroll.zz({ half_win_duration = 50 }) end;
      ["zb"]    = function() neoscroll.zb({ half_win_duration = 50 }) end;
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
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
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
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
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
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

    {
        -- Fuzzy Finder
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "master",
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
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
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
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })

            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

      require('telescope').setup {
        defaults = {
            path_display = function(_, path)
                local tail = require("telescope.utils").path_tail(path)
                return string.format("%s (%s)", tail, path)
            end,
        },
      }

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

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("gd", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map(
                        "<leader>ws",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[W]orkspace [S]ymbols"
                    )
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

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

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local servers = {
                clangd = {},
                cmakelang = {},
                cpplint = {},
                cpptools = {},
                pyright = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            }

            require("mason").setup()
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", 
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },

    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                },
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },
        config = function()
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

                mapping = cmp.mapping.preset.insert({
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
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
        branch = "main",
        build = ":TSUpdate",
        config = function()
            -- 1. Install parsers (opts/ensure_installed is no longer used)
            require("nvim-treesitter").install({
                "bash", "c", "cpp", "python", "lua", "markdown", "markdown_inline", "vim", "vimdoc"
            })

            -- 2. Enable native highlighting and indenting automatically
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function(args)
                    -- Start Treesitter highlighting safely
                    pcall(vim.treesitter.start, args.buf)
                    -- Enable Treesitter indentation
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },

  {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
}

}, {
    ui = {
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

vim.cmd("colorscheme tokyonight")

if vim.g.colors_name == "blue" then
    vim.api.nvim_set_hl(0, "MatchParen", {
      bg = "#666666",
      bold = true,
    })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "blue",
  callback = function()
    vim.api.nvim_set_hl(0, "MatchParen", {
      bg = "#666666",
      bold = true,
    })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
