return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			ignore_filetypes = { markdown = true, md = true },
		})
		local api = require("supermaven-nvim.api")
		vim.keymap.set("n", "ts", function()
			api.toggle()
		end, { desc = "toggle supermaven" })
	end,
}
