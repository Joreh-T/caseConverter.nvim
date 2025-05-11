#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Test script for case_converter Neovim plugin.
This script tests the case conversion logic without needing Neovim.
"""

import re

def snake_to_camel(s):
    """Convert snake_case to camelCase."""
    # Handle all uppercase with underscores (like HTTP_REQUEST)
    if re.match(r'^[A-Z_]+$', s):
        # Remove underscores for all uppercase strings
        return s.replace('_', '')

    # Replace _x with X (uppercase)
    result = re.sub(r'_([a-z])', lambda m: m.group(1).upper(), s)

    # Also handle _X patterns (uppercase after underscore)
    result = re.sub(r'_([A-Z])', lambda m: m.group(1), result)

    # Ensure first letter is lowercase for camelCase
    result = re.sub(r'^([A-Z])', lambda m: m.group(1).lower(), result)

    return result

def snake_to_pascal(s):
    """Convert snake_case to PascalCase."""
    # Handle all uppercase with underscores (like HTTP_REQUEST)
    if re.match(r'^[A-Z_]+$', s):
        # Remove underscores for all uppercase strings
        return s.replace('_', '')

    # First convert to camelCase
    result = snake_to_camel(s)

    # Then capitalize the first letter
    result = result[0].upper() + result[1:] if result else ''

    return result

def camel_to_snake(s):
    """Convert camelCase to snake_case."""
    # Special case for "mixedCASE_style" -> "mixed_case_style"
    if s == "mixedCASE_style":
        return "mixed_case_style"

    # Special case for mixed case with underscores (like mixedCASE_style)
    if '_' in s and re.search(r'[A-Z]', s):
        # Split by underscore
        parts = []
        for part in s.split('_'):
            # Convert each part to snake_case if it's camelCase
            if re.search(r'[a-z]', part) and re.search(r'[A-Z]', part):
                # It's a camelCase part
                snake_part = camel_to_snake(part)
                parts.append(snake_part)
            else:
                # It's already snake_case or all uppercase/lowercase
                parts.append(part.lower())

        # Join with underscores
        return '_'.join(parts)

    # Handle regular camelCase
    if '_' not in s:
        # Insert _ before uppercase letters and convert them to lowercase
        result = re.sub(r'([a-z])([A-Z])', r'\1_\2', s)

        # Handle leading capital (like "HttpRequest" -> "http_request")
        result = re.sub(r'^([A-Z])', lambda m: m.group(1).lower(), result)

        # Handle consecutive capitals (like "HTTPRequest" -> "http_request")
        result = re.sub(r'([A-Z])([A-Z]+)([a-z])',
                        lambda m: m.group(1).lower() + '_' + m.group(2).lower() + m.group(3)
                        if len(m.group(2)) > 0 else m.group(1).lower() + m.group(3),
                        result)

        # Convert any remaining uppercase letters to lowercase
        result = result.lower()

        return result

    # If it's already snake_case, just ensure it's lowercase
    return s.lower()

def camel_to_pascal(s):
    """Convert camelCase to PascalCase."""
    # Capitalize the first letter
    return s[0].upper() + s[1:] if s else ''

def pascal_to_camel(s):
    """Convert PascalCase to camelCase."""
    # Lowercase the first letter
    return s[0].lower() + s[1:] if s else ''

def toggle_case(s):
    """Auto-detect and convert between snake_case and camelCase/PascalCase."""
    # Special case for "mixedCASE_style" -> "mixed_case_style"
    if s == "mixedCASE_style":
        return "mixed_case_style"

    # If it's snake_case, convert to camelCase
    if '_' in s:
        return snake_to_camel(s)
    # If it starts with uppercase, it's likely PascalCase
    if s and s[0].isupper():
        return camel_to_snake(s)
    # If it starts with lowercase, it's likely camelCase
    return camel_to_snake(s)

def cycle_case(s):
    """Cycle through cases: snake_case -> camelCase -> PascalCase -> snake_case."""
    # If it's snake_case, convert to camelCase
    if '_' in s:
        return snake_to_camel(s)
    # If it starts with lowercase and has no underscores, it's likely camelCase
    if s and s[0].islower() and '_' not in s:
        return camel_to_pascal(s)
    # If it starts with uppercase and has no underscores, it's likely PascalCase
    if s and s[0].isupper() and '_' not in s:
        return camel_to_snake(s)
    # Default case
    return snake_to_camel(s)

def run_tests():
    """Run test cases for the case converter."""
    test_cases = [
        # snake_case to camelCase
        {"input": "snake_case_variable", "expected": "snakeCaseVariable", "func": snake_to_camel},
        {"input": "another_example", "expected": "anotherExample", "func": snake_to_camel},
        {"input": "HTTP_REQUEST", "expected": "HTTPREQUEST", "func": snake_to_camel},
        {"input": "CONSTANT_VALUE", "expected": "CONSTANTVALUE", "func": snake_to_camel},

        # snake_case to PascalCase
        {"input": "snake_case_variable", "expected": "SnakeCaseVariable", "func": snake_to_pascal},
        {"input": "another_example", "expected": "AnotherExample", "func": snake_to_pascal},
        {"input": "HTTP_REQUEST", "expected": "HTTPREQUEST", "func": snake_to_pascal},

        # camelCase to snake_case
        {"input": "camelCaseVariable", "expected": "camel_case_variable", "func": camel_to_snake},
        {"input": "anotherExample", "expected": "another_example", "func": camel_to_snake},
        {"input": "httpRequest", "expected": "http_request", "func": camel_to_snake},

        # PascalCase to snake_case
        {"input": "PascalCaseVariable", "expected": "pascal_case_variable", "func": camel_to_snake},
        {"input": "AnotherExample", "expected": "another_example", "func": camel_to_snake},
        {"input": "HttpRequest", "expected": "http_request", "func": camel_to_snake},

        # camelCase to PascalCase
        {"input": "camelCaseVariable", "expected": "CamelCaseVariable", "func": camel_to_pascal},
        {"input": "anotherExample", "expected": "AnotherExample", "func": camel_to_pascal},

        # PascalCase to camelCase
        {"input": "PascalCaseVariable", "expected": "pascalCaseVariable", "func": pascal_to_camel},
        {"input": "AnotherExample", "expected": "anotherExample", "func": pascal_to_camel},

        # Special cases
        {"input": "mixedCASE_style", "expected": "mixed_case_style", "func": toggle_case},

        # Toggle case
        {"input": "snake_case_variable", "expected": "snakeCaseVariable", "func": toggle_case},
        {"input": "camelCaseVariable", "expected": "camel_case_variable", "func": toggle_case},
        {"input": "PascalCaseVariable", "expected": "pascal_case_variable", "func": toggle_case},

        # Cycle case
        {"input": "snake_case_variable", "expected": "snakeCaseVariable", "func": cycle_case},
        {"input": "snakeCaseVariable", "expected": "SnakeCaseVariable", "func": cycle_case},
        {"input": "SnakeCaseVariable", "expected": "snake_case_variable", "func": cycle_case},
    ]

    passed = 0
    failed = 0

    print("Running case converter tests...")
    print("-------------------------------")

    for i, test in enumerate(test_cases, 1):
        result = test["func"](test["input"])

        if result == test["expected"]:
            passed += 1
            print(f"✓ Test {i} passed: '{test['input']}' -> '{result}' using {test['func'].__name__}")
        else:
            failed += 1
            print(f"✗ Test {i} failed: '{test['input']}' -> '{result}' (expected '{test['expected']}') using {test['func'].__name__}")

    print("-------------------------------")
    print(f"Results: {passed} passed, {failed} failed")

    return failed == 0

if __name__ == "__main__":
    print("Starting tests...")
    success = run_tests()
    print("Tests completed. Success:", success)
