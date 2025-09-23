return {
  {
    "GCBallesteros/jupytext.nvim",
    config = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
    opts = {
      custom_language_formatting = {
        -- python = {
        --   extension = "ipynb",
        --   style = "python",
        --   force_ft = nil, -- you can set whatever filetype you want here
        -- },
        -- markdown = {
        --   extension = "md",
        --   style = "markdown",
        --   force_ft = nil,
        -- }
      },
    },
  },
}
