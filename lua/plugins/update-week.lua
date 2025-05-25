return {

  {
    "LazyVim/LazyVim",
    optional = true,
    opts = function(_, opts)
      local function get_iso_week()
        return os.date("%V")
      end

      local function get_month_date()
        return os.date("%m-%d")
      end

      local function replace_pattern(pattern, replacement, description)
        local ok, result = pcall(function()
          local line = vim.fn.search(pattern, "n")
          if line == 0 then
            vim.notify("Pattern" .. description .. " found in file", vim.log.levels.INFO)
            return false
          end

          vim.cmd([[%s/]] .. pattern .. [[/]] .. replacement .. [[/g]])
          vim.notify("Replaced" .. pattern .. " with " .. replacement, vim.log.levels.INFO)
          return true
        end)

        if not ok then
          vim.notify("Error: " .. tostring(result), vim.log.levels.ERROR)
          return false
        end
        return result
      end
      vim.keymap.set("n", "<leader>hwk", function()
        replace_pattern("<<week>>", get_iso_week(), "week number")
      end, { desc = "Replace <<week>> with ISO week number" })

      vim.keymap.set("n", "<leader>hmd", function()
        replace_pattern("<<month>>-<<date>>", get_month_date(), "month-date")
      end, { desc = "Replace <<month-date>> with current month-date" })
    end,
  },
}
