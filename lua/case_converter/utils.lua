-- case_converter/utils.lua
-- Utility functions for case detection and Neovim integration

local M = {}

-- Detect if a string is in snake_case
function M.is_snake_case(str)
    -- Check if the string contains underscores
    return string.find(str, "_") ~= nil
end

-- Detect if a string is in camelCase (starts with lowercase)
function M.is_camel_case(str)
    -- Check if the string has no underscores, starts with lowercase, and has mixed case
    return string.find(str, "_") == nil and
           string.match(str, "^%l") ~= nil and
           string.find(str, "%l%u") ~= nil
end

-- Detect if a string is in PascalCase (starts with uppercase)
function M.is_pascal_case(str)
    -- Check if the string has no underscores, starts with uppercase, and has mixed case
    return string.find(str, "_") == nil and
           string.match(str, "^%u") ~= nil and
           string.find(str, "%u%l") ~= nil
end

-- Detect if a string is all uppercase
function M.is_all_uppercase(str)
    return string.match(str, "^%u+$") ~= nil
end

-- Get the visual selection
function M.get_visual_selection()
    -- Save the current register content
    local reg_save = vim.fn.getreg('"')
    local regtype_save = vim.fn.getregtype('"')
    
    -- Yank the visual selection into the unnamed register
    vim.cmd('normal! gvy')
    
    -- Get the content of the unnamed register
    local selection = vim.fn.getreg('"')
    
    -- Restore the register
    vim.fn.setreg('"', reg_save, regtype_save)
    
    return selection
end

-- Replace the visual selection with new text
function M.replace_visual_selection(text)
    -- Save the current register content
    local reg_save = vim.fn.getreg('"')
    local regtype_save = vim.fn.getregtype('"')
    
    -- Set the unnamed register to the new text
    vim.fn.setreg('"', text, 'v')
    
    -- Replace the visual selection with the unnamed register
    vim.cmd('normal! gvp')
    
    -- Restore the register
    vim.fn.setreg('"', reg_save, regtype_save)
end

return M
