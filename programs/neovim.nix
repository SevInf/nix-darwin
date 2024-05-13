{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraLuaConfig = ''
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
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
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
        config = "colorscheme onedark";
      }
    ];
  };
}