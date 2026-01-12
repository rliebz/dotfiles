return {
	"folke/sidekick.nvim",
	opts = {},
	event = "VeryLazy",
	keys = {
		-- {
		-- 	"<tab>",
		-- 	function()
		-- 		if not require("sidekick").nes_jump_or_apply() then
		-- 			return "<Tab>"
		-- 		end
		-- 	end,
		-- 	expr = true,
		-- 	desc = "Goto/Apply Next Edit Suggestion",
		-- },
		{
			"<c-.>",
			function() require("sidekick.cli").toggle({ name = "copilot" }) end,
			mode = { "n", "x", "i", "t" },
			desc = "Sidekick Toggle",
		},
		{
			"<leader>at",
			function() require("sidekick.cli").send({ name = "copilot", msg = "{this}" }) end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function() require("sidekick.cli").send({ name = "copilot", msg = "{file}" }) end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function() require("sidekick.cli").send({ name = "copilot", msg = "{selection}" }) end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function() require("sidekick.cli").prompt() end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	},
}
