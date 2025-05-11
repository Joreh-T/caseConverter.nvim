-- case_converter/commands.lua
-- Command and visual mode functions

local utils = require('case_converter.utils')
local converters = require('case_converter.converters')
local M = {}

-- Toggle case for the visual selection
function M.toggle_case_visual()
    -- Get the visual selection
    local selection = utils.get_visual_selection()
    
    -- Convert the case
    local converted = converters.toggle_case(selection)
    
    -- Replace the visual selection with the converted text
    utils.replace_visual_selection(converted)
end

-- Cycle through cases for the visual selection
function M.cycle_case_visual()
    -- Get the visual selection
    local selection = utils.get_visual_selection()
    
    -- Convert the case
    local converted = converters.cycle_case(selection)
    
    -- Replace the visual selection with the converted text
    utils.replace_visual_selection(converted)
end

-- Convert to snake_case for the visual selection
function M.to_snake_case_visual()
    -- Get the visual selection
    local selection = utils.get_visual_selection()
    
    -- Convert the case
    local converted = converters.to_snake_case(selection)
    
    -- Replace the visual selection with the converted text
    utils.replace_visual_selection(converted)
end

-- Convert to camelCase for the visual selection
function M.to_camel_case_visual()
    -- Get the visual selection
    local selection = utils.get_visual_selection()
    
    -- Convert the case
    local converted = converters.to_camel_case(selection)
    
    -- Replace the visual selection with the converted text
    utils.replace_visual_selection(converted)
end

-- Convert to PascalCase for the visual selection
function M.to_pascal_case_visual()
    -- Get the visual selection
    local selection = utils.get_visual_selection()
    
    -- Convert the case
    local converted = converters.to_pascal_case(selection)
    
    -- Replace the visual selection with the converted text
    utils.replace_visual_selection(converted)
end

-- Setup commands
function M.setup_commands()
    -- Create user commands
    vim.api.nvim_create_user_command('ToggleCase', function()
        M.toggle_case_visual()
    end, { range = true })
    
    vim.api.nvim_create_user_command('CycleCase', function()
        M.cycle_case_visual()
    end, { range = true })
    
    vim.api.nvim_create_user_command('ToSnakeCase', function()
        M.to_snake_case_visual()
    end, { range = true })
    
    vim.api.nvim_create_user_command('ToCamelCase', function()
        M.to_camel_case_visual()
    end, { range = true })
    
    vim.api.nvim_create_user_command('ToPascalCase', function()
        M.to_pascal_case_visual()
    end, { range = true })
end

-- Setup function to be called from the plugin file
function M.setup(opts)
    opts = opts or {}
    
    -- Setup commands
    M.setup_commands()
    
    -- Setup keymappings only if not disabled
    if opts.mappings ~= false then
        config.setup_keymaps(opts)
    end
    
    -- Return the module for chaining
    return M
end

return M

