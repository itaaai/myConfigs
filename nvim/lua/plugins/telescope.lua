return {
	-- {
	-- 	"nvim-telescope/telescope-fzf-native.nvim",
	-- 	build = "make", -- compile the native extension
	-- 	cond = vim.fn.executable("make") == 1,
	-- 	config = function()
	-- 		require("telescope").load_extension("fzf")
	-- 	end,
	-- },
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
		},
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,  -- move to prev result
							["<C-j>"] = actions.move_selection_next,      -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
							["<C-t>"] = actions.select_tab,               -- open in new tab
						},
						n = {
							["<C-t>"] = actions.select_tab, -- open in new tab
							["d"] = actions.delete_buffer, -- close buffers
						}
					}
				},
				pickers = {
					live_grep = {
						only_sort_text = true,
					}
				},
				extensions = {
					fzf = {
						fuzzy = true, -- enable fuzzy search
						override_generic_sorter = true, -- override default generic sorter
						override_file_sorter = true, -- override default file sorter
						case_mode = "smart_case", -- or "ignore_case" / "respect_case"
					},
				},
			})

			require('telescope').load_extension('fzf')

			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
			vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

			-- Rip grep + Fzf
			vim.keymap.set('n', '<leader>fg', function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") });
			end)

			-- Find instance instance of current view being included
			vim.keymap.set('n', '<leader>fc', function()
				local filename_without_extension = vim.fn.expand('%:t:r')
				builtin.grep_string({ search = filename_without_extension })
			end, { desc = "Find current file: " })

			-- Grep current string (for when gd doesn't work)
			vim.keymap.set('n', '<leader>fs', function()
				builtin.grep_string({})
			end, { desc = "Find current string: " })

			-- find files in vim config
			vim.keymap.set('n', '<leader>fi', function()
				builtin.find_files({ cwd = "~/.config/nvim/" });
			end)

			-- show jump list with current position selected
			vim.keymap.set('n', '<leader>fj', function()
				builtin.jumplist({ initial_mode = "normal", default_selection_index = 2 })
			end, { desc = 'Telescope jumplist' })
		end
	},
}
