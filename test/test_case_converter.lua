-- Test script for case_converter

-- Add the current directory to the Lua path
package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

-- Load the module
local case_converter = require('case_converter')

-- Mock vim functions for testing
_G.vim = {
    fn = {
        getreg = function() return "" end,
        getregtype = function() return "" end,
        setreg = function() end
    },
    cmd = function() end,
    api = {
        nvim_create_user_command = function() end,
        nvim_set_keymap = function() end
    }
}

-- Test cases
local test_cases = {
    -- snake_case to camelCase
    { input = "snake_case_variable", expected = "snakeCaseVariable", func = "snake_to_camel" },
    { input = "another_example", expected = "anotherExample", func = "snake_to_camel" },
    { input = "HTTP_REQUEST", expected = "HTTPREQUEST", func = "snake_to_camel" },
    { input = "CONSTANT_VALUE", expected = "CONSTANTVALUE", func = "snake_to_camel" },
    
    -- snake_case to PascalCase
    { input = "snake_case_variable", expected = "SnakeCaseVariable", func = "snake_to_pascal" },
    { input = "another_example", expected = "AnotherExample", func = "snake_to_pascal" },
    { input = "HTTP_REQUEST", expected = "HTTPREQUEST", func = "snake_to_pascal" },
    
    -- camelCase to snake_case
    { input = "camelCaseVariable", expected = "camel_case_variable", func = "camel_to_snake" },
    { input = "anotherExample", expected = "another_example", func = "camel_to_snake" },
    { input = "httpRequest", expected = "http_request", func = "camel_to_snake" },
    
    -- PascalCase to snake_case
    { input = "PascalCaseVariable", expected = "pascal_case_variable", func = "camel_to_snake" },
    { input = "AnotherExample", expected = "another_example", func = "camel_to_snake" },
    { input = "HttpRequest", expected = "http_request", func = "camel_to_snake" },
    
    -- camelCase to PascalCase
    { input = "camelCaseVariable", expected = "CamelCaseVariable", func = "camel_to_pascal" },
    { input = "anotherExample", expected = "AnotherExample", func = "camel_to_pascal" },
    
    -- PascalCase to camelCase
    { input = "PascalCaseVariable", expected = "pascalCaseVariable", func = "pascal_to_camel" },
    { input = "AnotherExample", expected = "anotherExample", func = "pascal_to_camel" },
    
    -- Special cases
    { input = "mixedCASE_style", expected = "mixed_case_style", func = "toggle_case" },
    
    -- Toggle case
    { input = "snake_case_variable", expected = "snakeCaseVariable", func = "toggle_case" },
    { input = "camelCaseVariable", expected = "camel_case_variable", func = "toggle_case" },
    { input = "PascalCaseVariable", expected = "pascal_case_variable", func = "toggle_case" },
    
    -- Cycle case
    { input = "snake_case_variable", expected = "snakeCaseVariable", func = "cycle_case" },
    { input = "snakeCaseVariable", expected = "SnakeCaseVariable", func = "cycle_case" },
    { input = "SnakeCaseVariable", expected = "snake_case_variable", func = "cycle_case" },
}

-- Run tests
local function run_tests()
    local passed = 0
    local failed = 0
    
    print("Running case converter tests...")
    print("-------------------------------")
    
    for i, test in ipairs(test_cases) do
        local result = case_converter[test.func](test.input)
        
        if result == test.expected then
            passed = passed + 1
            print(string.format("✓ Test %d passed: '%s' -> '%s' using %s", 
                i, test.input, result, test.func))
        else
            failed = failed + 1
            print(string.format("✗ Test %d failed: '%s' -> '%s' (expected '%s') using %s", 
                i, test.input, result, test.expected, test.func))
        end
    end
    
    print("-------------------------------")
    print(string.format("Results: %d passed, %d failed", passed, failed))
    
    return failed == 0
end

-- Execute tests
run_tests()
