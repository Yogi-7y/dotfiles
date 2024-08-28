return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	opts = {
		provider = "copilot",
		claude = {
			model = "claude-3-sonnet-20240229",
			temperature = 0,
			max_tokens = 4096,
		},
		copilot = {
			endpoint = "https://api.githubcopilot.com",
			model = "gpt-4o-2024-05-13",
			proxy = nil, -- [protocol://]host[:port] Use this proxy
			allow_insecure = false, -- Allow insecure server connections
			timeout = 30000, -- Timeout in milliseconds
			temperature = 0,
			max_tokens = 4096,
		},
		mappings = {},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
