local fn = vim.fn

-- Automatically install packer local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
 vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/plenary.nvim" }) -- Common utilities
  	use({
	    "kyazdani42/nvim-tree.lua",
	    requires = { 'kyazdani42/nvim-web-devicons' },
	    config = function()
	      require('nvim-web-devicons').setup()

	      require('nvim-tree').setup {
		hijack_cursor = true,
		view = {
		  width = 40
		}
	      }
	    end
	  })
	use ({'neoclide/coc.nvim', branch = 'release'})
	use ({'nvim-tree/nvim-web-devicons'})
	use ({'lewis6991/gitsigns.nvim'}) 
	use ({'romgrk/barbar.nvim'})
	use ({'catppuccin/nvim', as = 'catppuccin'})
	use ({
		'nvim-telescope/telescope.nvim',  
		tag='0.1.6', 
		requires={{'nvim-lua/plenary.nvim'}}
	})
	use({'preservim/nerdcommenter'})
	-- Colorschemes
	use ({'folke/tokyonight.nvim'})
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
