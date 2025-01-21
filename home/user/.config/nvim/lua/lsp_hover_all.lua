local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
local throttle = require('throttle')

-- throttled function to call textDocumentohover for all lsp clients
-- and join the contents in a single floating window
local lsp_hover_all = throttle(function(_, _, ctx, config)
  -- silently return if not loaded yet
  if not ctx then
    return
  end

  local clients = get_clients({ bufnr = ctx.bufnr, method = ctx.method })
  local remaining = #clients
  local hover_cache = nil

  for _, client in ipairs(clients) do
    -- calls textDocument/hover in each client
    client.request(ctx.method, ctx.params, function(_, result)
      remaining = remaining - 1

      if not (result and result.contents and result.contents.value) then
        return
      end

      if not hover_cache then
        hover_cache = result
      else
        hover_cache.contents.value = hover_cache.contents.value .. '\n---\n' .. result.contents.value
      end

      -- call original hover with the joined result of all clients
      if remaining == 0 then
        return vim.lsp.handlers.hover(_, hover_cache, ctx, config)
      end
    end, ctx.bufnr)
  end
end, 100) -- ms

return lsp_hover_all
