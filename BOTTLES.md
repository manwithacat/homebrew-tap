# Homebrew Bottles Guide

Bottles are pre-compiled binary packages that make installation nearly instant (~30 seconds vs ~15 minutes).

## Quick Start (For Users)

Once bottles are available, installation is automatic and fast:

```bash
brew tap manwithacat/tap
brew install dazzle  # Uses bottle automatically
```

## For Maintainers: Building Bottles

### Prerequisites

- macOS machine (or CI/CD runner)
- Homebrew installed
- Push access to tap repository

### Manual Bottle Building

#### Step 1: Build the bottle locally

```bash
# Tap your formula
brew tap manwithacat/tap

# Install with bottle building enabled
brew install --build-bottle dazzle

# Create the bottle
brew bottle dazzle
```

This creates files like:
- `dazzle--0.1.0.arm64_sequoia.bottle.tar.gz`
- `dazzle--0.1.0.bottle.json`

#### Step 2: Upload bottles to GitHub Releases

```bash
# Create a release (if not exists)
gh release create v0.1.0-bottles --title "Bottles for v0.1.0"

# Upload bottle file
gh release upload v0.1.0-bottles dazzle--0.1.0.*.bottle.tar.gz
```

#### Step 3: Update formula with bottle info

```bash
# This updates the formula with bottle stanzas
brew bottle --merge --write dazzle--0.1.0.bottle.json
```

This adds to the formula:
```ruby
bottle do
  root_url "https://github.com/manwithacat/homebrew-tap/releases/download/v0.1.0-bottles"
  sha256 cellar: :any_skip_relocation, arm64_sequoia: "abc123..."
  sha256 cellar: :any_skip_relocation, ventura: "def456..."
end
```

#### Step 4: Commit and push

```bash
git add Formula/dazzle.rb
git commit -m "Add bottles for dazzle 0.1.0"
git push
```

### Building for Multiple Architectures

To support both Apple Silicon and Intel:

**On Apple Silicon Mac:**
```bash
brew install --build-bottle dazzle
brew bottle dazzle
# Produces: dazzle--0.1.0.arm64_sequoia.bottle.tar.gz
```

**On Intel Mac or using Rosetta:**
```bash
arch -x86_64 brew install --build-bottle dazzle
arch -x86_64 brew bottle dazzle
# Produces: dazzle--0.1.0.ventura.bottle.tar.gz
```

**Using GitHub Actions (recommended):**
See `.github/workflows/bottle-build.yml`

## Automated Bottle Building (Future)

### GitHub Actions Approach

The included workflow (`.github/workflows/bottle-build.yml`) automates:
1. Building bottles on multiple macOS versions
2. Uploading to GitHub Releases
3. Creating PR with updated formula

To enable:
1. Ensure workflow file is committed
2. Push a tag: `git tag v0.1.0 && git push --tags`
3. GitHub Actions builds bottles automatically
4. Review and merge the PR

### Homebrew's Official Bot (Advanced)

For formulas in homebrew-core, there's an official bot. For third-party taps:

1. Request access: https://github.com/Homebrew/homebrew-test-bot
2. Add to your tap's CI
3. Automatic bottle builds on every PR

## Bottle Architecture Matrix

| OS Version | Architecture | Bottle Name | Install Time |
|------------|--------------|-------------|--------------|
| macOS 14+ | Apple Silicon | `arm64_sequoia` | ~30 sec |
| macOS 14+ | Intel | `sonoma` | ~30 sec |
| macOS 13 | Apple Silicon | `arm64_ventura` | ~30 sec |
| macOS 13 | Intel | `ventura` | ~30 sec |
| No bottle | Any | Falls back to source | ~15 min |

## Troubleshooting

### Bottle not used

```bash
# Check if bottle is available
brew info dazzle

# Force bottle usage (fails if not available)
brew install --force-bottle dazzle
```

### Building fails

```bash
# Clean everything
brew cleanup -s
brew uninstall dazzle

# Rebuild from scratch
brew install --build-bottle --verbose dazzle
```

### Bottle size optimization

Bottles for dazzle should be ~13-17MB. If larger:
- Check for debug symbols
- Verify stripped binaries
- Review included files

## For v0.1.0

**Current status**: Bottles not yet built
**Installation method**: Build from source (~15 min first time)
**Alternative**: Use `pipx install dazzle` for faster install

**Planned**: Bottles for v0.1.1 or v0.2.0
