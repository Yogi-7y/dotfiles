local bufnr = 262

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("Yogi", { clear = true }),
	pattern = "autosave.dart",
	callback = function()
		print("Wow! we saved a file.")
		vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {
			"hello",
			"world",
		})
	end,
})
