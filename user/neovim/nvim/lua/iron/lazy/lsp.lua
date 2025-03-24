return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"MysticalDevil/inlay-hints.nvim",
	},

	config = function()
		require("inlay-hints").setup()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})

		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "Lua 5.1" },
					diagnostics = {
						globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
					},
					hint = {
						enable = true,
					},
				},
			},
		})

		lspconfig.nil_ls.setup({})

		lspconfig.rust_analyzer.setup({
			settings = {
				Rust = {
					hint = {
						enable = true,
					},
				},
			},
		})

		lspconfig.clangd.setup({
			on_attach = function(client, _)
				client.server_capabilities.signatureHelpProvider = false
			end,
			capabilities = capabilities,
			settings = {
				clangd = {
					hint = {
						enable = true,
					},
				},
			},
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = { "*.hl", "hypr*.conf" },
			callback = function(event)
				print(string.format("starting hyprls for %s", vim.inspect(event)))
				vim.lsp.start({
					name = "hyprlang",
					cmd = { "hyprls" },
					root_dir = vim.fn.getcwd(),
				})
			end,
		})

		local luasnip = require("luasnip")

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				expandable_indicator = true,
			},
			performance = {
				debounce = 60,
				fetching_timeout = 200,
				max_view_entries = 30,
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
				border = "rounded",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
			},
			mapping = cmp.mapping.preset.insert({
				["<C-m>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<enter>"] = cmp.mapping.confirm(cmp_select),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
