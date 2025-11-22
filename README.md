# Homebrew Tap for DAZZLE

Official Homebrew tap for [DAZZLE](https://github.com/manwithacat/dazzle) - a DSL-first application framework with LLM-assisted development.

## Installation

```bash
# Add the tap
brew tap manwithacat/tap

# Install DAZZLE
brew install dazzle
```

Or install directly without tapping:

```bash
brew install manwithacat/tap/dazzle
```

## Usage

After installation, you can use DAZZLE commands:

```bash
# Initialize a new project
dazzle init my-project
cd my-project

# Validate your DSL
dazzle validate

# Build your application
dazzle build

# Get help
dazzle --help
```

## What's in this Tap

- **dazzle** - DSL-first application framework for building apps with LLM assistance

## Requirements

- macOS (Apple Silicon or Intel)
- Homebrew
- Python 3.12+ (installed automatically as dependency)
- Rust compiler (installed automatically as build dependency)

## Installation Details

The formula installs:
- DAZZLE CLI tool (`dazzle` command)
- Python virtualenv with all dependencies (pydantic, typer, rich, etc.)
- DSL templates and examples

**Installation size**: ~17MB
**Build dependencies**: Rust (~2GB, removed after installation)
**Installation time**: ~15 minutes (includes Rust compilation)

## Optional: LLM Features

To enable LLM-powered features (spec analysis, DSL generation):

```bash
/opt/homebrew/opt/dazzle/libexec/bin/pip install anthropic openai
```

## Optional: VS Code Extension

If you use VS Code, install the DAZZLE DSL extension:

```bash
code --install-extension dazzle.dazzle-dsl
```

Configure the Python path in VS Code settings:

```json
{
  "dazzle.pythonPath": "/opt/homebrew/opt/dazzle/libexec/bin/python"
}
```

## Upgrading

```bash
brew update
brew upgrade dazzle
```

## Uninstalling

```bash
brew uninstall dazzle
brew untap manwithacat/tap  # Optional: remove the tap
```

## Documentation

- [Main Repository](https://github.com/manwithacat/dazzle)
- [DSL Reference](https://github.com/manwithacat/dazzle/blob/main/docs/DAZZLE_DSL_REFERENCE_0_1.md)
- [Examples](https://github.com/manwithacat/dazzle/tree/main/docs/examples)

## Troubleshooting

### Command not found

Ensure Homebrew's bin directory is in your PATH:

```bash
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Build failures

If installation fails during Rust compilation:

```bash
# Clean and retry
brew cleanup
brew install --build-from-source dazzle
```

### Missing dependencies

If you get import errors:

```bash
# Verify installation
brew info dazzle

# Reinstall if needed
brew reinstall dazzle
```

## Contributing

Issues and pull requests for the formula should be submitted to:
- Formula issues: This repository
- DAZZLE issues: https://github.com/manwithacat/dazzle/issues

## License

The formula in this tap is licensed under MIT.
DAZZLE itself is licensed under MIT - see the [main repository](https://github.com/manwithacat/dazzle) for details.
