-- Test script for case_converter

-- Define the conversion functions directly for testing
local M = {}

-- Convert snake_case to camelCase
function M.snake_to_camel(str)
    -- Handle all uppercase with underscores (like HTTP_REQUEST)
    if string.match(str, "^[%u_]+$") then
        -- Remove underscores for all uppercase strings
        return string.gsub(str, "_", "")
    end

    -- Replace _x with X (uppercase)
    local result = string.gsub(str, "_(%l)", function(c) return string.upper(c) end)

    -- Also handle _X patterns (uppercase after underscore)
    result = string.gsub(result, "_(%u)", function(c) return c end)

    return result
end

-- Convert camelCase to snake_case
function M.camel_to_snake(str)
    -- Special case for mixed case with underscores (like mixedCASE_style)
    if string.find(str, "_") and string.find(str, "%u") then
        -- Split by underscore
        local parts = {}
        for part in string.gmatch(str, "[^_]+") do
            -- Convert each part to snake_case if it's camelCase
            if string.find(part, "%l") and string.find(part, "%u") then
                -- It's a camelCase part
                local snake_part = M.camel_to_snake(part)
                table.insert(parts, snake_part)
            else
                -- It's already snake_case or all uppercase/lowercase
                table.insert(parts, string.lower(part))
            end
        end
        -- Join with underscores
        return table.concat(parts, "_")
    end

    -- Handle regular camelCase
    if not string.find(str, "_") then
        -- Insert _ before uppercase letters and convert them to lowercase
        local result = string.gsub(str, "(%l)(%u)", function(l, u) return l .. "_" .. string.lower(u) end)

        -- Handle leading capital (like "HttpRequest" -> "http_request")
        result = string.gsub(result, "^(%u)", function(c) return string.lower(c) end)

        -- Handle consecutive capitals (like "HTTPRequest" -> "http_request")
        result = string.gsub(result, "(%u)(%u+)(%l)", function(first, rest, last)
            if #rest > 0 then
                return string.lower(first) .. "_" .. string.lower(rest) .. last
            else
                return string.lower(first) .. last
            end
        end)

        -- Convert any remaining uppercase letters to lowercase
        result = string.lower(result)

        return result
    end

    -- If it's already snake_case, just ensure it's lowercase
    return string.lower(str)
end

-- Auto-detect and convert between snake_case and camelCase
function M.toggle_case(str)
    if string.find(str, "_") then
        return M.snake_to_camel(str)
    else
        -- If it's not snake_case, treat it as camelCase or mixed
        return M.camel_to_snake(str)
    end
end

-- Test cases
local test_cases = {
    -- snake_case to camelCase
    { input = "snake_case_variable", expected = "snakeCaseVariable" },
    { input = "another_example", expected = "anotherExample" },
    { input = "HTTP_REQUEST", expected = "HTTPREQUEST" },
    { input = "CONSTANT_VALUE", expected = "CONSTANTVALUE" },

    -- camelCase to snake_case
    { input = "camelCaseVariable", expected = "camel_case_variable" },
    { input = "anotherExample", expected = "another_example" },
    { input = "httpRequest", expected = "http_request" },
    { input = "mixedCASE_style", expected = "mixed_case_style" },
}

-- Run tests
local function run_tests()
    local passed = 0
    local failed = 0

    print("Running case converter tests...")
    print("-------------------------------")

    for i, test in ipairs(test_cases) do
        local result = M.toggle_case(test.input)

        if result == test.expected then
            passed = passed + 1
            print(string.format("✓ Test %d passed: '%s' -> '%s'", i, test.input, result))
        else
            failed = failed + 1
            print(string.format("✗ Test %d failed: '%s' -> '%s' (expected '%s')",
                i, test.input, result, test.expected))
        end
    end

    print("-------------------------------")
    print(string.format("Results: %d passed, %d failed", passed, failed))

    return failed == 0
end

-- Execute tests
run_tests()
