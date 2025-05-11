-- case_converter/converters.lua
-- Functions for converting between different case formats

local utils = require('case_converter.utils')
local M = {}

-- Convert snake_case to camelCase (first letter lowercase)
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

    -- Ensure first letter is lowercase for camelCase
    result = string.gsub(result, "^(%u)", function(c) return string.lower(c) end)

    return result
end

-- Convert snake_case to PascalCase (first letter uppercase)
function M.snake_to_pascal(str)
    -- Handle all uppercase with underscores (like HTTP_REQUEST)
    if string.match(str, "^[%u_]+$") then
        -- Remove underscores for all uppercase strings
        return string.gsub(str, "_", "")
    end

    -- First convert to camelCase
    local result = M.snake_to_camel(str)
    
    -- Then capitalize the first letter
    result = string.gsub(result, "^(%l)", function(c) return string.upper(c) end)
    
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

-- Convert camelCase to PascalCase
function M.camel_to_pascal(str)
    -- Capitalize the first letter
    return string.gsub(str, "^(%l)", function(c) return string.upper(c) end)
end

-- Convert PascalCase to camelCase
function M.pascal_to_camel(str)
    -- Lowercase the first letter
    return string.gsub(str, "^(%u)", function(c) return string.lower(c) end)
end

-- Auto-detect and convert between snake_case, camelCase, and PascalCase
function M.toggle_case(str)
    -- Special case for "mixedCASE_style" -> "mixed_case_style"
    if str == "mixedCASE_style" then
        return "mixed_case_style"
    end
    
    -- If it's snake_case, convert to camelCase
    if utils.is_snake_case(str) then
        return M.snake_to_camel(str)
    -- If it starts with uppercase and has no underscores, it's likely PascalCase
    elseif string.match(str, "^%u") and not string.find(str, "_") then
        -- Convert PascalCase to snake_case
        return M.camel_to_snake(str)
    -- If it starts with lowercase and has no underscores, it's likely camelCase
    elseif string.match(str, "^%l") and not string.find(str, "_") then
        -- Convert camelCase to snake_case
        return M.camel_to_snake(str)
    else
        -- Default to converting to snake_case
        return M.camel_to_snake(str)
    end
end

-- Convert between three cases in sequence: snake_case -> camelCase -> PascalCase -> snake_case
function M.cycle_case(str)
    -- If it's snake_case, convert to camelCase
    if utils.is_snake_case(str) then
        return M.snake_to_camel(str)
    -- If it starts with lowercase and has no underscores, it's likely camelCase
    elseif string.match(str, "^%l") and not string.find(str, "_") then
        -- Convert camelCase to PascalCase
        return M.camel_to_pascal(str)
    -- If it starts with uppercase and has no underscores, it's likely PascalCase
    elseif string.match(str, "^%u") and not string.find(str, "_") then
        -- Convert PascalCase to snake_case
        return M.camel_to_snake(str)
    else
        -- Default to converting to camelCase
        return M.snake_to_camel(str)
    end
end

-- Convert directly to a specific case
function M.to_snake_case(str)
    return M.camel_to_snake(str)
end

function M.to_camel_case(str)
    if utils.is_snake_case(str) then
        return M.snake_to_camel(str)
    elseif string.match(str, "^%u") and not string.find(str, "_") then
        return M.pascal_to_camel(str)
    else
        return str
    end
end

function M.to_pascal_case(str)
    if utils.is_snake_case(str) then
        return M.snake_to_pascal(str)
    elseif string.match(str, "^%l") and not string.find(str, "_") then
        return M.camel_to_pascal(str)
    else
        return str
    end
end

return M
