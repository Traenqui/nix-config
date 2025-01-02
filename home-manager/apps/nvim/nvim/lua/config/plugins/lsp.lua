return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").lua_ls.setup({ capabilites = capabilities })

      require("lspconfig").nixd.setup({
        cmd = { "nixd" },
        capabilities = capabilities,
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(args)
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = args.buf, desc = "LSP: [G]oto [D]efinition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "LSP: [G]oto [D]eclaration" })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = args.buf, desc = "LSP: [G]oto [R]eferences" })
          vim.keymap.set("n", "gI", builtin.lsp_implementations, {
            buffer = args.buf,
            desc = "LSP: [G]oto [I]mplementation",
          })
          vim.keymap.set(
            "n",
            "gt",
            builtin.lsp_type_definitions,
            { buffer = args.buf, desc = "LSP: [G]oto [T]ype Definition" }
          )
          vim.keymap.set(
            "n",
            "<leader>ds",
            builtin.lsp_document_symbols,
            { buffer = args.buf, desc = "LSP: [D]ocument [S]ymbols" }
          )
          vim.keymap.set(
            "n",
            "<leader>ws",
            builtin.lsp_dynamic_workspace_symbols,
            { buffer = args.buf, desc = "LSP: [W]orkspace [S]ymbols" }
          )
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "LSP: [R]e[n]name" })
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            { buffer = args.buf, desc = "LSP: [C]ode [A]ction" }
          )
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "LSP: Hover" })

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = args.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = args.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
            end, { desc = "[T]oggle Inlay [H]ints", buffer = args.buf })
          end
        end,
      })
    end,
  },
}
