return {
    'stevearc/oil.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {
      deleteToTrash = true,
      useDefaultKeymaps = true,
        viewOptions = {
          showHidden = true,
        },
        preview = {
          border = "rounded",
          win_options = {
            winblend = 0,
          },

        },

        float = {
          padding = 2,
          maxWidth = 0,
          maxHeight = 0,
          border = "rounded",
          winOptions = {
            winblend = 0,
          },
        },
    },
    config = function ()
    require("oil").setup()
     vim.keymap.set('n', '<leader>o', ':Oil --float<CR>', { desc = 'Open oil' })
    end
}
