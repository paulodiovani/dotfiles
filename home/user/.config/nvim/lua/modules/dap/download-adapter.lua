---@class DapAdapterDownloader
local M = {}

---Download and extract a DAP adapter from GitHub releases
---@param repo string GitHub repository in "user/repo" format
---@param opts table Options table containing:
---  - version: string (required) Version tag (e.g., "v1.105.0")
---  - prefix: string (required) Filename prefix for the release file
---@return nil
function M.download_adapter(repo, opts)
  if not repo or not opts.version or not opts.prefix then
    vim.notify("Repository, version, and prefix are required", vim.log.levels.ERROR)
    return
  end

  local dap_dir = vim.fn.stdpath("data") .. "/dap"
  local version = opts.version
  local filename = opts.prefix .. "-" .. version .. ".tar.gz"

  local download_url = "https://github.com/" .. repo .. "/releases/download/" .. version .. "/" .. filename

  -- Create directories if they don't exist
  vim.fn.mkdir(dap_dir, "p")

  -- Download and extract adapter asynchronously
  local function download_and_extract()
    local download_file = dap_dir .. "/" .. filename

    vim.notify("Downloading " .. repo .. " adapter...", vim.log.levels.INFO)

    -- Download
    local download_cmd = string.format("curl -L -o %s %s", download_file, download_url)
    vim.fn.jobstart(download_cmd, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          -- Extract directly to adapter directory
          local extract_cmd = string.format("tar -xzf %s -C %s", download_file, dap_dir)
          vim.fn.jobstart(extract_cmd, {
            on_exit = function(_, extract_exit_code)
              if extract_exit_code == 0 then
                vim.notify(repo .. " adapter downloaded successfully", vim.log.levels.INFO)
              else
                vim.notify("Failed to extract " .. repo .. " adapter", vim.log.levels.ERROR)
              end
            end
          })
        else
          vim.notify("Failed to download " .. repo .. " adapter", vim.log.levels.ERROR)
        end
      end
    })
  end

  -- Start download in the background
  vim.defer_fn(download_and_extract, 100)
end

return M
