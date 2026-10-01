{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;

    initLua = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.shiftround = true
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.clipboard = 'unnamed'
      local vimrc_group = vim.api.nvim_create_augroup('vimrc', { clear = true })

      function enable_spellcheck(file_type)
        vim.api.nvim_create_autocmd({ 'FileType' }, {
          pattern = file_type,
          group = vimrc_group,
          callback = function ()
            vim.opt_local.spell = true
            vim.opt_local.spelllang = {'en_US'}
          end
        })
      end

      enable_spellcheck('gitcommit')
      enable_spellcheck('markdown')

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
            pattern = "*",
            callback = function(event)
              pcall(vim.treesitter.start, event.buf)
            end,
          })
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = "require('nvim-autopairs').setup {}";
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = "require('ibl').setup()";
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = "require('lualine').setup()";
      }
      {
        plugin = onedarkpro-nvim;
        type = "viml";
        config = "colorscheme onedark";
      }
      {
        plugin = blink-cmp;
        type = "lua";
        config = ''
          require("blink.cmp").setup({
            keymap = { preset = "super-tab" },
            signature = {
              enabled = true,
              window = { border = "rounded" },
              trigger = {
                 show_on_accept = true,
               },
            },
            completion = {
              documentation = {
                auto_show = true,
                auto_show_delay_ms = 300,
                window = { border = "rounded" },
              },
            },
            sources = {
              default = { "lsp", "path", "snippets", "buffer" },
            },
          })
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          vim.lsp.config("ts_ls", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
          })

          vim.lsp.enable({ "ts_ls", "rust_analyzer" })
        '';
      }
    ];
    extraPackages = with pkgs; [
      typescript
      typescript-language-server
      rust-analyzer
    ];
  };
}
