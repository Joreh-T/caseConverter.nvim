-- case_converter/config.lua
-- Configuration handling

local M = {}

-- Default configuration
M.defaults = {
    -- Enable default mappings
    mappings = true,
    
    -- Default mappings
    toggle_mapping = '<Leader>tt',  -- Toggle between cases
    cycle_mapping = '<Leader>tc',   -- Cycle through cases
    snake_mapping = '<Leader>ts',   -- Convert to snake_case
    camel_mapping = '<Leader>tm',   -- Convert to camelCase
    pascal_mapping = '<Leader>tp'   -- Convert to PascalCase
}

-- Setup keymappings
function M.setup_keymaps(opts)
    if opts.mappings ~= false then
        -- Default mappings in visual mode
        local toggle_mapping = opts.toggle_mapping or M.defaults.toggle_mapping
        local cycle_mapping = opts.cycle_mapping or M.defaults.cycle_mapping
        local snake_mapping = opts.snake_mapping or M.defaults.snake_mapping
        local camel_mapping = opts.camel_mapping or M.defaults.camel_mapping
        local pascal_mapping = opts.pascal_mapping or M.defaults.pascal_mapping
        
        vim.api.nvim_set_keymap('v', toggle_mapping, ':<C-u>ToggleCase<CR>', { noremap = true, silent = true, desc = "Convert between snake and camel" })
        vim.api.nvim_set_keymap('v', cycle_mapping, ':<C-u>CycleCase<CR>', { noremap = true, silent = true, desc = "Cycle through cases"})
        vim.api.nvim_set_keymap('v', snake_mapping, ':<C-u>ToSnakeCase<CR>', { noremap = true, silent = true,  desc = "Convert to snake_case"})
        vim.api.nvim_set_keymap('v', camel_mapping, ':<C-u>ToCamelCase<CR>', { noremap = true, silent = true, desc = "Convert to camelCase"})
        vim.api.nvim_set_keymap('v', pascal_mapping, ':<C-u>ToPascalCase<CR>', { noremap = true, silent = true, desc = "Convert to PascalCase"})
    end
end

return M
