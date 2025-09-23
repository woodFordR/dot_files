-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/neovim/bin/python3"

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.rtp:prepend(os.getenv "HOME" .. "/.config/nvim/lua/plugins")

-- require("molten.status").initialized() -- "Molten" or "" based on initialization information
-- require("molten.status").kernels() -- "kernel1 kernel2" list of kernels attached to buffer or ""
--- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = false

-- this guide will be using image.nvim
-- Don't forget to setup and install the plugin if you want to view image outputs
vim.g.molten_image_provider = "image.nvim"

-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = true

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
-- vim.g.molten_virt_lines_off_by_1 = true - require("molten-nvim").all_kernels() -- same as kernels, but will show all kernels

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

local quarto = require "quarto"
quarto.setup {
  lspFeatures = {
    languages = { "r", "python", "rust" },
    chunks = "all",
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" },
    },
    completion = {
      enabled = true,
    },
  },
  keymap = {
    hover = "H",
    definition = "gd",
    rename = "<leader>rn",
    references = "gr",
    format = "<leader>gf",
  },
  codeRunner = {
    enabled = true,
    default_method = "molten",
  },
}

local runner = require "quarto.runner"
vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set(
  "n",
  "<localleader>RA",
  function() runner.run_all(true) end,
  { desc = "run all cells of all languages", silent = true }
)

local imb = function(e) -- init molten buffer
  vim.schedule(function()
    local kernels = vim.fn.MoltenAvailableKernels()
    local try_kernel_name = function()
      local metadata = vim.json.decode(io.open(e.file, "r"):read "a")["metadata"]
      return metadata.kernelspec.name
    end
    local ok, kernel_name = pcall(try_kernel_name)
    if not ok or not vim.tbl_contains(kernels, kernel_name) then
      kernel_name = nil
      local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
      if venv ~= nil then kernel_name = string.match(venv, "/.+/(.+)") end
    end
    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      vim.cmd(("MoltenInit %s"):format(kernel_name))
    end
    vim.cmd "MoltenImportOutput"
  end)
end

vim.api.nvim_create_autocmd("BufAdd", {
  pattern = { "*.ipynb" },
  callback = imb,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ipynb" },
  callback = function(e)
    if vim.api.nvim_get_vvar "vim_did_enter" ~= 1 then imb(e) end
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ipynb" },
  callback = function()
    if require("molten.status").initialized() == "Molten" then vim.cmd "MoltenExportOutput!" end
  end,
})

require("lspconfig")["pyright"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportUnusedExpression = "none",
        },
      },
    },
  },
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function(e)
    if string.match(e.file, ".otter.") then return end
    if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
      vim.fn.MoltenUpdateOption("virt_text_output", false)
    else
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_virt_text_output = false
    end
  end,
})

-- Undo those config changes when we go back to a markdown or quarto file
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.qmd", "*.md", "*.ipynb" },
  callback = function(e)
    if string.match(e.file, ".otter.") then return end
    if require("molten.status").initialized() == "Molten" then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
      vim.fn.MoltenUpdateOption("virt_text_output", true)
    else
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_output = true
    end
  end,
})
