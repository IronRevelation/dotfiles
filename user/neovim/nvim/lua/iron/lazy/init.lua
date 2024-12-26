return {
	{
		"edluffy/hologram.nvim",
		config = function()
			require("hologram").setup({
				auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
			})
		end,
	},
	"tpope/vim-sleuth",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	"norcalli/nvim-colorizer.lua",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"MeanderingProgrammer/render-markdown.nvim",
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}
