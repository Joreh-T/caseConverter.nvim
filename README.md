# Case Converter

A Neovim plugin that converts between snake_case and camelCase in visual mode.

## Features

- Automatically detects the current case format (snake_case or camelCase)
- Converts snake_case to camelCase and vice versa
- Works in visual mode
- Customizable keybindings

## Installation

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'Joreh-T/caseConverter.nvim',
  config = function()
    require('case_converter').setup({
      -- Optional configuration
    })
  end
}
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'Joreh-T/caseConverter.nvim',
  config = function()
    require('case_converter').setup({
      -- Optional configuration
    })
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'Joreh-T/caseConverter.nvim'
```

## Usage

1. Select text in visual mode
2. Use one of the following keybindings:
   - `<Leader>tt` - Toggle between snake_case and camelCase/PascalCase
   - `<Leader>tc` - Cycle through cases: snake_case → camelCase → PascalCase → snake_case
   - `<Leader>ts` - Convert to snake_case
   - `<Leader>tm` - Convert to camelCase
   - `<Leader>tp` - Convert to PascalCase

## Commands

- `:ToggleCase` - Toggle case for the current visual selection
- `:CycleCase` - Cycle through cases for the current visual selection
- `:ToSnakeCase` - Convert to snake_case
- `:ToCamelCase` - Convert to camelCase
- `:ToPascalCase` - Convert to PascalCase

## Configuration

You can customize the plugin by passing options to the setup function:

```lua
require('case_converter').setup({
  -- Disable default mappings
  mappings = false,

  -- Or customize the default mappings
  toggle_mapping = '<Leader>tt',  -- Toggle between cases
  cycle_mapping = '<Leader>tc',   -- Cycle through cases
  snake_mapping = '<Leader>ts',   -- Convert to snake_case
  camel_mapping = '<Leader>tm',   -- Convert to camelCase
  pascal_mapping = '<Leader>tp'   -- Convert to PascalCase
})
```

## Examples

- snake_case ↔ camelCase ↔ PascalCase:
  - `snake_case_variable` ↔ `snakeCaseVariable` ↔ `SnakeCaseVariable`
  - `another_example` ↔ `anotherExample` ↔ `AnotherExample`
  - `HTTP_REQUEST` ↔ `httpRequest` ↔ `HttpRequest`

## License

MIT
