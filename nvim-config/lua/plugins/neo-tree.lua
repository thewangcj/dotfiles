local neo_tree_default = require('config.keybindings').neoTreeDefaultList
local neo_tree_fileSystem = require('config.keybindings').neoTreeFileSystem
local neo_tree_buffer = require('config.keybindings').neoTreeBuffer

return { -- If you want neo-tree's file operations to work with LSP (updating imports, etc.), you can use a plugin like
-- https://github.com/antosha417/nvim-lsp-file-operations:
-- {
--   "antosha417/nvim-lsp-file-operations",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-neo-tree/neo-tree.nvim",
--   },
--   config = function()
--     require("lsp-file-operations").setup()
--   end,
-- },
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
                    {
        "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = {"neo-tree", "neo-tree-popup", "notify"},
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = {"terminal", "quickfix"}
                    }
                }
            })
        end
    }},
    lazy = false,
    -----Instead of using `config`, you can use `opts` instead, if you'd like:
    -----@module "neo-tree"
    -----@type neotree.Config
    -- opts = {},
    config = function()
        -- If you want icons for diagnostic errors, you'll need to define them somewhere.
        -- In Neovim v0.10+, you can configure them in vim.diagnostic.config(), like:
        --
        -- vim.diagnostic.config({
        --   signs = {
        --     text = {
        --       [vim.diagnostic.severity.ERROR] = '',
        --       [vim.diagnostic.severity.WARN] = '',
        --       [vim.diagnostic.severity.INFO] = '',
        --       [vim.diagnostic.severity.HINT] = '󰌵',
        --     },
        --   }
        -- })
        --
        -- In older versions, you can define the signs manually:
        -- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
        -- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
        -- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
        -- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

        require("neo-tree").setup({
            close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = {"terminal", "trouble", "qf"}, -- when opening files, do not use windows containing these filetypes or buftypes
            open_files_using_relative_paths = false,
            sort_case_insensitive = false, -- used when sorting files and directories in the tree
            sort_function = nil, -- use a custom function for sorting files and directories in the tree
            -- sort_function = function (a,b)
            --       if a.type == b.type then
            --           return a.path > b.path
            --       else
            --           return a.type > b.type
            --       end
            --   end , -- this sorts files and directories descendantly
            default_component_configs = {
                container = {
                    enable_character_fade = true
                },
                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander"
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
                        if node.type == "file" or node.type == "terminal" then
                            local success, web_devicons = pcall(require, "nvim-web-devicons")
                            local name = node.type == "terminal" and "terminal" or node.name
                            if success then
                                local devicon, hl = web_devicons.get_icon(name)
                                icon.text = devicon or icon.text
                                icon.highlight = hl or icon.highlight
                            end
                        end
                    end,
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified"
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName"
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = "✖", -- this can only be used in the git_status source
                        renamed = "󰁕", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = ""
                    }
                },
                -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                file_size = {
                    enabled = true,
                    width = 12, -- width of the column
                    required_width = 64 -- min width of window required to show this column
                },
                type = {
                    enabled = true,
                    width = 10, -- width of the column
                    required_width = 122 -- min width of window required to show this column
                },
                last_modified = {
                    enabled = true,
                    width = 20, -- width of the column
                    required_width = 88 -- min width of window required to show this column
                },
                created = {
                    enabled = true,
                    width = 20, -- width of the column
                    required_width = 110 -- min width of window required to show this column
                },
                symlink_target = {
                    enabled = false
                }
            },
            -- A list of functions, each representing a global custom command
            -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
            -- see `:h neo-tree-custom-commands-global`
            commands = {},
            window = {
                position = "left",
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true
                },
                mappings = neo_tree_default
            },
            nesting_rules = {},
            filesystem = {
                filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_hidden = true, -- only works on Windows for hidden files/directories
                    hide_by_name = {
                        -- "node_modules"
                    },
                    hide_by_pattern = { -- uses glob style patterns
                        -- "*.meta",
                        -- "*/src/*/tsconfig.json",
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                        -- ".gitignored",
                    },
                    always_show_by_pattern = { -- uses glob style patterns
                        -- ".env*",
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        -- ".DS_Store",
                        -- "thumbs.db"
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                        -- ".null-ls_*",
                    }
                },
                follow_current_file = {
                    enabled = false, -- This will find and focus the file in the active buffer every time
                    --               -- the current file is changed while the tree is open.
                    leave_dirs_open = false -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = false, -- when true, empty folders will be grouped together
                hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                -- instead of relying on nvim autocmd events.
                window = {
                    mappings = neo_tree_fileSystem,
                    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                        ["<down>"] = "move_cursor_down",
                        ["<C-n>"] = "move_cursor_down",
                        ["<up>"] = "move_cursor_up",
                        ["<C-p>"] = "move_cursor_up",
                        ["<esc>"] = "close"
                        -- ['<key>'] = function(state, scroll_padding) ... end,
                    }
                },

                commands = {} -- Add a custom command or override a global one using the same function name
            },
            buffers = {
                follow_current_file = {
                    enabled = true, -- This will find and focus the file in the active buffer every time
                    --              -- the current file is changed while the tree is open.
                    leave_dirs_open = false -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                group_empty_dirs = true, -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = neo_tree_buffer
                }
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                        ["o"] = {
                            "show_help",
                            nowait = false,
                            config = {
                                title = "Order by",
                                prefix_key = "o"
                            }
                        },
                        ["oc"] = {
                            "order_by_created",
                            nowait = false
                        },
                        ["od"] = {
                            "order_by_diagnostics",
                            nowait = false
                        },
                        ["om"] = {
                            "order_by_modified",
                            nowait = false
                        },
                        ["on"] = {
                            "order_by_name",
                            nowait = false
                        },
                        ["os"] = {
                            "order_by_size",
                            nowait = false
                        },
                        ["ot"] = {
                            "order_by_type",
                            nowait = false
                        }
                    }
                }
            }
        })
    end
}}
