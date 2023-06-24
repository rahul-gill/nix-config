{ config, pkgs, lib, ... }:

{

	imports = [
		<home-manager/nixos>
	];
  home-manager.users.ashenone = {
    config, pkgs, lib, ... }: {
    home.stateVersion = "23.05";
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      meslo-lgs-nf
    ];
    programs.zsh = {
      enable = true;
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      initExtra = ''
        source ~/.p10k.zsh
      '';
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
    };


	programs.git = {
		enable = true;
		userName = "Rahul Gill";
		userEmail = "rgill1@protonmail.com";
	};

    programs.neovim = {
      enable = true;
      extraLuaConfig = ''
        -- Set line numbers
        vim.opt.number = true
        vim.opt.relativenumber = true

        -- Indentation settings
        vim.opt.autoindent = true
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.smarttab = true
        vim.opt.softtabstop = 4

        -- Mouse configuration
        vim.opt.mouse = "a"

        -- Plugin configuration
        -- call plug#begin()
        -- call plug#end()

        -- Shift left and right
        vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true })
        vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true })
        vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-d>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true })

        -- Nerdtree shortcuts
        vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFocus<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })

        -- Enable treesitter highlighting
        require'nvim-treesitter.configs'.setup {
          --ensure_installed = { "c", "cpp", "kotlin", "rust" },
          --auto_install = true,
          highlight = {
            enable = true,
          }
        }

        -- Status bar mod
        vim.g.airline_section_z = '[%l:%c]/%L %p%%'

        -- Commenting
        vim.api.nvim_set_keymap('n', '<C-_>', ':Commentary<CR>', { noremap = true })
        vim.api.nvim_set_keymap('i', '<C-_>', '<Esc>:Commentary<CR>i', { noremap = true })
        vim.api.nvim_set_keymap('v', '<C-_>', ':Commentary<CR>', { noremap = true })

        -- Keep search terms in middle
        vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
        vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

        -- System clipboard copy
        vim.api.nvim_set_keymap('v', '<C-y>', '"+y', { noremap = true })

      '';
      plugins = with pkgs.vimPlugins; [
        vim-airline
        nerdtree
        vim-commentary
        nerdtree-git-plugin
        nvim-treesitter.withAllGrammars
      ];
    };
  };
}

