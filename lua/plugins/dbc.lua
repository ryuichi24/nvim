local logger = require("utils.logger"):new({ name = "plugins.dbc" })

logger:debug("Loading plugins.dbc...")

vim.pack.add({ "https://github.com/ryuichi24/dbc.nvim" })

require("dbc").setup({
	connections = {
		-- {
		-- 	name = "local-mysql",
		-- 	adapter = "mysql",
		-- 	provider = "direct",
		-- 	host = "127.0.0.1",
		-- 	port = 3306,
		-- 	login_path = "local",
		-- 	-- database = "my_database", -- omit to browse available databases
		-- },
		-- Add an RDS profile after setting your IAM DB username and CA bundle path:
		-- {
		-- 	name = "core-dev-read",
		-- 	adapter = "mysql",
		-- 	database = "coredb",
		-- 	provider = {
		-- 		name = "aws_ssm_rds_iam",
		-- 		aws_profile = "core_dev",
		-- 		region = "ap-northeast-1",
		-- 		rds_identifier = "core-dev-aurora-cluster",
		-- 		endpoint = "writer",
		-- 		ecs_cluster = "core-dev-infra02",
		-- 		ecs_service = "core-dev-bastion-service",
		-- 		db_user = "your_user_read",
		-- 		local_port = 13360,
		-- 		ssl_ca = "/absolute/path/to/global-bundle.pem",
		-- 	},
		-- },
	},
	execution = { timeout_ms = 60000 },
	ui = {
		panes = {
			sidebar = { number = true, relativenumber = true },
			query = { number = true, relativenumber = true },
			results = { number = true, relativenumber = true },
		},
	},
})

vim.keymap.set("n", "<leader>db", function()
	require("dbc").open()
end, { desc = "Open database dashboard" })

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
	pattern = "dbc://query/*",
	callback = function(event)
		vim.keymap.set("n", "<leader>dp", function()
			require("dbc.workspace").pick_query()
		end, {
			buffer = event.buf,
			desc = "Search query tabs",
		})

		vim.keymap.set("n", "<leader>dr", function()
			require("dbc.workspace").run()
		end, {
			buffer = event.buf,
			desc = "Run a db query",
		})

		vim.keymap.set("n", "<leader>dc", function()
			require("dbc.workspace").close_query()
		end, { desc = "Close current query tab" })

		vim.keymap.set("n", "<C-t>", function()
			require("dbc.workspace").next_query()
		end, { desc = "Next query tab" })

		vim.keymap.set("n", "<C-g>", function()
			require("dbc.workspace").previous_query()
		end, { desc = "Previous query tab" })
	end,
})
