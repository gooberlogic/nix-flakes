require("CopilotChat").setup({
  dependencies = {
    -- { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  opts = {

  },
  providers = {
    -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/discussions/1306
    openwebui = {
      prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
      prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,
      get_headers = function()
        local api_key = assert(os.getenv('OPENWEBUI_API_KEY'), 'OPENWEBUI_API_KEY env not set')
        return {
          Authorization = 'Bearer ' .. api_key,
          ['Content-Type'] = 'application/json',
        }
      end,
      get_models = function(headers)
        local response, err = require('CopilotChat.utils').curl_get('http://localhost:11435/api/models', {
          headers = headers,
          json_response = true,
        })
        if err then
          error(err)
        end
        return vim.tbl_map(function(model)
          return {
            id = model.id,
            name = model.id,
          }
        end, response.body.data)
      end,
      get_url = function()
        return 'http://localhost:11435/api/chat/completions'
      end,
    }
  }
})
