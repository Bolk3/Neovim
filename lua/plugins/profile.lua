-- lua/plugins/profile.lua
--
-- Layout visé :
--   ┌────────────┐
--   │    logo    │
--   └────────────┘
--   update: ────────────────
--
--       github activites
--   ────────────────────────
--   shortcuts:      recent files
--     f  find files    ~/foo.lua
--     r  oldfiles       ~/bar.lua
--     u  update config  ...
 
local M = {}
local categories = require("config.categories")
local env = require("utils.env")
 
-- ---------------------------------------------------------------------
-- 1. Vérifier / appliquer les mises à jour de la config (git)
-- ---------------------------------------------------------------------
local config_dir = vim.fn.stdpath("config")
 
-- résultat mis en cache pour ne pas refaire un fetch à chaque redraw
M.update_status = "…" -- "…" | "à jour" | "N commit(s) en retard" | "erreur"
 
function M.check_updates(on_done)
  vim.system({ "git", "-C", config_dir, "fetch", "--quiet" }, { text = true }, function(fetch_res)
    if fetch_res.code ~= 0 then
      vim.schedule(function()
        M.update_status = "erreur"
        if on_done then on_done() end
      end)
      return
    end
    vim.system(
      { "git", "-C", config_dir, "rev-list", "--count", "HEAD..origin/main" },
      { text = true },
      function(res)
        local behind = tonumber(vim.trim(res.stdout or "0")) or 0
        vim.schedule(function()
          M.update_status = behind == 0 and "à jour" or (behind .. " commit(s) en retard")
          if on_done then on_done() end
        end)
      end
    )
  end)
end
 
function M.update_config()
  vim.system({ "git", "-C", config_dir, "pull", "--ff-only" }, { text = true }, function(res)
    vim.schedule(function()
      if res.code == 0 then
        vim.notify("Config mise à jour, redémarre Neovim.", vim.log.levels.INFO)
        M.update_status = "à jour"
      else
        vim.notify("Échec du pull:\n" .. res.stderr, vim.log.levels.ERROR)
      end
    end)
  end)
end
 
-- rempli à chaque rendu du dashboard (voir format() plus bas)
M.recent_files = {}
 
--- Ouvre le n-ième fichier récent affiché dans le dashboard.
function M.open_recent(n)
  local file = M.recent_files[n]
  if file then
    vim.cmd("edit " .. vim.fn.fnameescape(file))
  end
end
 
-- ---------------------------------------------------------------------
-- 2. Raccourcis à afficher dans la colonne de gauche
-- ---------------------------------------------------------------------
local shortcuts = {
  { key = "f", desc = "find files" },
  { key = "r", desc = "oldfiles" },
  { key = "/", desc = "live grep" },
  { key = "c", desc = "config files" },
  { key = "u", desc = "update config" },
  { key = "l", desc = "lazy" },
}
 
-- complète une chaîne avec des espaces jusqu'à `width` (largeur d'affichage)
local function pad(str, width)
  str = str or ""
  local len = vim.fn.strdisplaywidth(str)
  return str .. string.rep(" ", math.max(0, width - len))
end
 
-- largeur de la colonne "touche" (juste la touche, pas la description),
-- calculée sur la touche la plus large + 2 espaces de respiration
local KEY_COL_WIDTH = (function()
  local max = 0
  for _, sc in ipairs(shortcuts) do
    max = math.max(max, vim.fn.strdisplaywidth(sc.key))
  end
  return max + 2
end)()
 
-- largeur totale de la colonne gauche (touche alignée + description la plus longue)
local LEFT_COL_WIDTH = (function()
  local max = vim.fn.strdisplaywidth("shortcuts:")
  for _, sc in ipairs(shortcuts) do
    local text = pad(sc.key, KEY_COL_WIDTH) .. sc.desc
    max = math.max(max, vim.fn.strdisplaywidth(text))
  end
  return max
end)()
local GUTTER = " │ "
 
-- logo ASCII affiché en haut du dashboard
local ascii_logo = {
  "░▒▓███████▓▒░░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░",
}
 
-- ---------------------------------------------------------------------
-- 3. plugin spec
-- ---------------------------------------------------------------------
return {
  {
    "Kurama622/profile.nvim",
    config = function()
    local comp = require("profile.components")
 
    -- lus depuis ~/.config/nvim/.env (voir .env.example)
    local github_user = env.get("GITHUB_USERNAME")
 
    require("profile").setup({
      user = github_user,
 
      git_contributions = {
        start_week = 1,
        end_week = 53,
        empty_char = " ",
        full_char = { "", "󰧞", "", "", "" },
        cache_path = "/tmp/profile.nvim/",
        cache_duration = 24 * 60 * 60,
      },
 
      hide = { statusline = true, tabline = true },
      disable_keys = { "h", "j", "k", "<Left>", "<Right>", "<Up>", "<Down>", "<C-f>" },
      cursor_pos = { 0, 0 },
 
      format = function()
        -- 1) logo ASCII
        for _, line in ipairs(ascii_logo) do
          comp:text_component_render({
            comp:text_component(line, "center", "ProfileGreen"),
          })
        end
 
        -- 1bis) profil actif + statut de mise à jour + signature, même ligne
        -- (le statut n'est affiché que si la catégorie "git" est active)
        local status_line = "profil: " .. categories.get_profile()
        if categories.is_enabled("git") then
          status_line = status_line .. GUTTER .. "update: " .. M.update_status
        end
        status_line = status_line .. GUTTER .. "by Bolk3"
        local status_offset = math.max(
          0,
          math.floor((vim.api.nvim_win_get_width(0) - vim.fn.strdisplaywidth(status_line)) / 2)
        )
        comp:text_component_render({
          comp:text_component(string.rep(" ", status_offset) .. status_line, "left", "ProfileYellow"),
        })
        comp:separator_render()
 
        -- 3) mur d'activité github (uniquement si la catégorie "extra" est active)
        if categories.is_enabled("extra") then
          comp:text_component_render({
            comp:text_component("github activites", "center", "ProfileBlue"),
          })
          comp:git_contributions_render("ProfileGreen")
          comp:separator_render()
        end
 
        -- 4) shortcuts (gauche) / recent files (droite), fusionnés en une seule
        -- ligne centrée pour que tout le bloc soit visuellement centré,
        -- avec les fichiers récents numérotés (1..6)
        local oldfiles = vim.v.oldfiles or {}
        local nb_files = math.min(#oldfiles, 6)
        local rows = math.max(#shortcuts, nb_files)
 
        -- expose la liste affichée pour que les mappings numériques (1..6)
        -- sachent quel fichier ouvrir
        M.recent_files = {}
        for i = 1, nb_files do
          M.recent_files[i] = oldfiles[i]
        end
 
        -- construit d'abord toutes les lignes (texte brut) du bloc, header inclus
        local block_lines = { pad("shortcuts:", LEFT_COL_WIDTH) .. GUTTER .. "recent files" }
        for i = 1, rows do
          local sc = shortcuts[i]
          local left = sc and (pad(sc.key, KEY_COL_WIDTH) .. sc.desc) or ""
 
          local file = oldfiles[i]
          local right = file and (i .. ". " .. vim.fn.fnamemodify(file, ":~:.")) or ""
 
          block_lines[#block_lines + 1] = pad(left, LEFT_COL_WIDTH) .. GUTTER .. right
        end
 
        -- padde chaque ligne à la largeur max du bloc entier, pour que les
        -- colonnes restent alignées d'une ligne à l'autre (sinon "right"
        -- varie en longueur et décale la colonne de gauche selon les lignes)
        local block_width = 0
        for _, line in ipairs(block_lines) do
          block_width = math.max(block_width, vim.fn.strdisplaywidth(line))
        end
 
        -- on calcule nous-même l'offset de centrage (plutôt que de compter
        -- sur l'alignement "center" du plugin, dont on ne connaît pas le
        -- comportement exact vis-à-vis des espaces de fin de ligne) : ça
        -- garantit un centrage identique et cohérent sur toutes les lignes
        local win_width = vim.api.nvim_win_get_width(0)
        local offset = math.max(0, math.floor((win_width - block_width) / 2))
        local offset_str = string.rep(" ", offset)
 
        for i, line in ipairs(block_lines) do
          local hl = (i == 1) and "ProfileYellow" or "ProfileText"
          comp:text_component_render({
            comp:text_component(offset_str .. pad(line, block_width), "left", hl),
          })
        end
      end,
    })
 
    -- lance le check de mise à jour en tâche de fond dès le chargement
    -- (inutile de faire un git fetch si le bloc ne sera de toute façon pas affiché)
    if categories.is_enabled("git") then
      M.check_updates()
    end
 
    vim.keymap.set("n", "<leader>p", function()
      require("profile"):instance()
    end, { desc = "Return to main menu"}) 

    local user_mappings = {
      n = {
        ["r"] = "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
        ["f"] = "<cmd>lua require('telescope.builtin').find_files()<cr>",
        ["c"] = "<cmd>lua require('telescope.builtin').find_files({ cwd = '$HOME/.config/nvim' })<cr>",
        ["/"] = "<cmd>lua require('telescope.builtin').live_grep()<cr>",
        ["n"] = "<cmd>enew<cr>",
        ["l"] = "<cmd>Lazy<cr>",
        ["u"] = "<cmd>lua require('plugins.profile').update_config()<cr>",
	["q"] = "<cmd>q<cr>",
      },
    }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "profile",
      callback = function()
        for mode, mapping in pairs(user_mappings) do
          for key, cmd in pairs(mapping) do
            vim.api.nvim_buf_set_keymap(0, mode, key, cmd, { noremap = true, silent = true })
          end
        end
 
        -- 1..6 : ouvre le fichier récent correspondant au numéro affiché
        for i = 1, 6 do
          vim.keymap.set("n", tostring(i), function()
            M.open_recent(i)
          end, { buffer = true, silent = true })
        end
      end,
    })
    end,
  },
}
