

-- -- tokyonight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
local colors = require('tokyonight.colors').setup()
vim.cmd 'colorscheme tokyonight'

-- -- -- nightfox
-- local nightfox = require('nightfox')

-- -- This function set the configuration of nightfox. If a value is not passed in the setup function
-- -- it will be taken from the default configuration above
-- nightfox.setup({
--   fox = "nordfox", -- change the colorscheme to use one of the various themes
--   styles = {
--     comments = "italic", -- change style of comments to be italic
--     keywords = "bold", -- change style of keywords to be bold
--     functions = "italic,bold" -- styles can be a comma separated list
--   },
--   inverse = {
--     match_paren = true,
--   },
--   colors = {},
--   hlgroup = {}
-- })

-- -- Load the configuration set above and apply the colorscheme
-- nightfox.load()


-- local colors = require('kanagawa.colors').setup()
-- vim.cmd 'colorscheme kanagawa'


-- nvim-scrollbar colors to match colorscheme
require('scrollbar').setup({
    handle = {
        color = colors.bg_highlight,
    },
    marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    }
})

