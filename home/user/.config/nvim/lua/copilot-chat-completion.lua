local copilot_chat = require('CopilotChat')
local cmp = require('cmp')

-- Configure cmp completion
local source = {}

function source:get_trigger_characters()
  local info = copilot_chat.complete_info()
  return info['triggers']
end

function source:get_keyword_pattern()
  local info = copilot_chat.complete_info()
  return info['pattern']
end

function source:complete(_, callback)
  local items = copilot_chat.complete_items()
  local mapped_items = vim.tbl_map(function(item)
    return {
      label = item.word,
      kind = vim.lsp.protocol.CompletionItemKind[item.kind] or vim.lsp.protocol.CompletionItemKind.Text,
      detail = item.info,
      documentation = item.menu,
    }
  end, items)
  callback(mapped_items)
end

function source:execute(completion_item, callback)
  callback(completion_item)
end

cmp.register_source('copilot_chat', source)

cmp.setup.filetype('copilot-chat', {
  completion = {
    autocomplete = false,
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  sources = {
    { name = 'copilot_chat' },
  },
})
