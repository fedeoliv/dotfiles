return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons

      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end
      return {
        options = {
          theme = "material",
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },
          lualine_b = { "filename", "branch" },
          -- lualine_c = {
          --   {
          --     "diagnostics",
          --     symbols = {
          --       error = icons.diagnostics.Error,
          --       warn = icons.diagnostics.Warn,
          --       info = icons.diagnostics.Info,
          --       hint = icons.diagnostics.Hint,
          --     },
          --   },
          --   { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          --   { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          -- -- stylua: ignore
          -- {
          --   function() return require("nvim-navic").get_location() end,
          --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          -- },
          -- },
          lualine_c = {
            function()
              local fn = vim.fn.expand("%:~:.")
              if vim.startswith(fn, "jdt://") then
                fn = string.sub(fn, 0, string.find(fn, "?") - 1)
              end
              if fn == "" then
                fn = "[No Name]"
              end
              if vim.bo.modified then
                fn = fn .. " [+]"
              end
              if vim.bo.modifiable == false or vim.bo.readonly == true then
                fn = fn .. " [-]"
              end
              local tfn = vim.fn.expand("%")
              if tfn ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(tfn) == 0 then
                fn = fn .. " [New]"
              end
              return fn
            end,
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = fg("Debug"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = fg("Constant"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            { " " .. os.date("%R"), separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },
}
