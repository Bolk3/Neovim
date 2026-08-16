vim.api.nvim_create_user_command("Profile", function()
	local mode = require("config.categories")
	local profiles = require("config.profiles")

	local items = {}
	for _, name in ipairs(profiles.order) do
		local mark = (mode.get_profile() == name) and "[X]" or "[ ]"
		table.insert(items, mark .. " " .. name)
	end

	vim.ui.select(items, {
		prompt = "Choisis un profil:",
	}, function(choice, idx)
		if not choice then return end
		local name = profiles.order[idx]
		mode.set_profile(name)
		vim.notify("Profil '" .. name .. "' activé. Redémarre nvim pour appliquer.")

		if name == "custom" then
			vim.cmd("Modes")
		end
	end)
end, {})
