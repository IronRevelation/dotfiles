return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		require("flutter-tools").setup({
			lsp = { settings = { lineLength = 120 } },
		})
		vim.keymap.set("n", "<leader>fru", ":FlutterRun<CR>")
		vim.keymap.set("n", "<leader>fdb", ":FlutterDebug<CR>")
		vim.keymap.set("n", "<leader>fdv", ":FlutterDevices<CR>")
		vim.keymap.set("n", "<leader>frl", ":FlutterReload<CR>")
		vim.keymap.set("n", "<leader>ftl", ":FlutterLogToggle<CR>")
		vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>")
		vim.keymap.set("n", "<leader>frn", ":FlutterRename<CR>")
		return true
	end,
}
