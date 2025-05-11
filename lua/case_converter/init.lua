-- case_converter/init.lua
-- A Neovim plugin to convert between snake_case, camelCase and PascalCase

-- Import modules
local utils = require('case_converter.utils')
local converters = require('case_converter.converters')
local commands = require('case_converter.commands')
local config = require('case_converter.config')

local M = {}

-- Export converter functions
M.snake_to_camel = converters.snake_to_camel
M.snake_to_pascal = converters.snake_to_pascal
M.camel_to_snake = converters.camel_to_snake
M.camel_to_pascal = converters.camel_to_pascal
M.pascal_to_camel = converters.pascal_to_camel
M.toggle_case = converters.toggle_case
M.cycle_case = converters.cycle_case
M.to_snake_case = converters.to_snake_case
M.to_camel_case = converters.to_camel_case
M.to_pascal_case = converters.to_pascal_case

-- Export visual mode functions
M.toggle_case_visual = commands.toggle_case_visual
M.cycle_case_visual = commands.cycle_case_visual
M.to_snake_case_visual = commands.to_snake_case_visual
M.to_camel_case_visual = commands.to_camel_case_visual
M.to_pascal_case_visual = commands.to_pascal_case_visual

-- Export utility functions
M.get_visual_selection = utils.get_visual_selection
M.replace_visual_selection = utils.replace_visual_selection

-- Setup function to be called from the plugin file
function M.setup(opts)
    opts = opts or {}

    -- Setup commands
    commands.setup_commands()

    -- Setup keymappings
    config.setup_keymaps(opts)
end

return M
