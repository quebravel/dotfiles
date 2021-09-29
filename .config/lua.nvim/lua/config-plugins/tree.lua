-- NvimTree
vim.g['nvim_tree_ignore'] = { '.git', 'node_modules', '.cache' }
vim.g['nvim_tree_gitignore'] = 1
vim.g['nvim_tree_hide_dotfiles'] = 0
vim.g['nvim_tree_git_hl'] = 1
vim.g['nvim_tree_highlight_opened_files'] = 1
vim.g['nvim_tree_show_icons'] = { folder_arrows = 0, git = 1, files = 1, folders = 1 }
vim.g['nvim_tree_highlight_opened_files'] = 2
vim.g['nvim_tree_indent_markers'] = 1

-- following options are the default
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  lsp_diagnostics     = false,
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
    ignore_list = { '*.git', 'node_modules', '.cache' }
  },
  system_open = {
    cmd  = nil,
    args = {}
  },

  view = {
    width = 30,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}
