-- lua/core/plugins_lazy/cmp.lua

return {
	"hrsh7th/nvim-cmp",
	lazy = true,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Custom bash completion source
		cmp.register_source("bash", {
			complete = function(_, _, callback)
				local handle = io.popen('bash -c "compgen -c"')
				if handle then
					local result = handle:read("*a")
					handle:close()
					local items = {}
					for cmd in string.gmatch(result, "[^\n]+") do
						table.insert(items, { label = cmd })
					end
					callback({ items = items, isIncomplete = false })
				else
					callback({ items = {}, isIncomplete = true })
				end
			end,
		})

		cmp.setup({
			snippet = {
				expand = function(args) luasnip.lsp_expand(args.body) end,
			},
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				-- { name = "bash" },
			}),
			formatting = {
				format = function(entry, vim_item)
					local ci = entry.completion_item

					-- 1. LSP function signature (THIS is what you were missing)
					if ci.labelDetails and ci.labelDetails.detail then
						vim_item.abbr = ci.label .. ci.labelDetails.detail
					end

					-- 2. keep documentation (your existing logic, fixed safely)
					if ci.documentation then
						vim_item.documentation = ci.documentation
					end

					-- 3. preserve kind (DON'T append label here)
					vim_item.kind = vim_item.kind

					-- 4. menu labels (unchanged)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						buffer = "[Buffer]",
						path = "[Path]",
						bash = "[Bash]",
					})[entry.source.name]

					return vim_item
				end,
			},
		})

		-- Helper function for cmdline completion
		local function setup_cmdline(type, sources)
			cmp.setup.cmdline(type, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = sources,
				enabled = function()
					local cmdline = vim.fn.getcmdline()
					if type == ":" then
						if cmdline:sub(1, 1) == "!" then
							return true
						end
						return true
					elseif type == "/" then
						return true
					else
						return false
					end
				end,
			})
		end

		setup_cmdline("/", { { name = "buffer" } })
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}, {
				{
					name = "bash",
					entry_filter = function()
						local cmdline = vim.fn.getcmdline()
						return cmdline:sub(1, 1) == "!"
					end,
				},
			}),
		})
	end,
}
