-- case_converter.lua
-- Plugin loader for case_converter

-- Prevent loading the plugin multiple times
if vim.g.loaded_case_converter == 1 then
    return
end
vim.g.loaded_case_converter = 1

-- Load and setup the plugin
require('case_converter').setup()
