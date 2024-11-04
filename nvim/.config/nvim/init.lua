local in_vscode = vim.g.vscode ~= nil

if not in_vscode then
	require("yogi.core.init")
	require("yogi.lazy")
	vim.o.exrc = true
	vim.o.secure = true
end
