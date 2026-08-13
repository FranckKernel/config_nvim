-- https://github.com/mks-h/treesitter-autoinstall.nvim for autoinstall. If there's a bug, check what he posted, he might have found a fix
return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- build = ":TSUpdate",
		-- branch = "master", -- nvim 0.11 implementation
		branch = "main",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup({
				indent = { enable = true, disable = { "latex" } },
			})

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.dump",
				callback = function() vim.bo.filetype = "asm" end,
			})

			local nvim_treesitter = require("nvim-treesitter")
			local function is_installed(lang)
				local installed = nvim_treesitter.get_installed()
				return vim.list_contains(installed, lang)
			end

			local function has_parser(lang) return vim.list_contains(nvim_treesitter.get_available(), lang) end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					local lang = vim.treesitter.language.get_lang(ft)

					if not lang then
						return
					end

					-- 1. ensure parser exists
					if is_installed(lang) then
						vim.treesitter.start(args.buf, lang)

					-- Step 5: Check if the parser is available (exists in treesitter repo)
					elseif not has_parser(lang) then
						return -- Can't install if it doesn't exist
					end

					nvim_treesitter.install(lang):await(function()
						-- Only enable if the buffer is still loaded
						if not vim.api.nvim_buf_is_loaded(args.buf) then
							return
						end
						vim.treesitter.start(args.buf, lang)
					end)

					-- pcall(vim.treesitter.start, args.buf, lang)

					-- Folds
					-- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					-- vim.wo[0][0].foldmethod = "expr"

					-- Indentation
					-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- local parsers = require("nvim-treesitter.parsers")
			-- local install = require("nvim-treesitter.install")
			--
			-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			-- 	callback = function()
			-- 		local ft = vim.bo.filetype
			--
			-- 		-- Prevent trying to install unsupported or unknown filetypes
			-- 		if not ft or ft == "" then
			-- 			return
			-- 		end
			--
			-- 		local lang = parsers.ft_to_lang(ft)
			--
			-- 		-- Don't install if no parser exists for this language
			-- 		if not parsers.get_parser_configs()[lang] then
			-- 			return
			-- 		end
			--
			-- 		-- Only install if not already available
			-- 		if not parsers.has_parser(lang) then
			-- 			vim.schedule(function() install.ensure_installed({ lang }) end)
			-- 		end
			-- 	end,
			-- })
		end,
	},
}
