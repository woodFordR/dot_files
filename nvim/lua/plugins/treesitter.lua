return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
    config = function()
      require("nvim-treesitter.configs").setup {
        textobjects = {
          move = {
            enable = true,
            set_jumps = false,
            goto_next_start = {
              ["]c"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_previous_start = {
              ["[c"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["ib"] = { query = "@code_cell.inner", desc = "in block" },
              ["ab"] = { query = "@code_cell.outer", desc = "around block" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sbl"] = "@code_cell.outer",
            },
            swap_previous = {
              ["<leader>sbh"] = "@code_cell.outer",
            },
          },
        },
        ensure_installed = { "c", "python", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = true,
        sync_install = false,
        ignore_install = { "javascript" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighing = false,
        },
      }
    end,
  },
}
