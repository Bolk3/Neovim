vim.api.nvim_create_user_command("Categories",
function()
	local	mode = require("config.categories")

	local function build_items()
		local items = {}
		for _, m in ipairs(mode.modes) do
			local mark = mode.current_state()[m] and "[X]" or "[ ]"
			table.insert(items, mark .. " " .. m)
		end
		table.insert(items, "-- confirm and quit --")
		return items
	end

	local function open_menu()
		local items = build_items()
		local quit_index = #items

		vim.ui.select(items, {
			prompt = "Toggle categories",
		}, function(choice, idx)
			if not choice then return end

			if idx == quit_index then
				mode.set_profile("custom") -- active le custom qu'on vient d'éditer
				mode.save()
				vim.notify("Restart Nvim to apply changes")
				return
			end

			local mode_name = mode.modes[idx]
			mode.toggle_custom(mode_name)
			vim.cmd("redraw")
			open_menu()
		end)
	end

	open_menu()
end, {})
