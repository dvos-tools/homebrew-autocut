# Autocut Homebrew Tap

Install autocut with:

```bash
brew tap dvos-tools/autocut
brew install autocut
```

## Usage

```bash
# Start the service
brew services start autocut

# Configure shortcuts
autocut-setup

# Check status
brew services list | grep autocut
```

## Development

```bash
# Install from local directory
HOMEBREW_AUTOCUT_DEV=1 brew install ./homebrew-tap/Formula/autocut.rb
```

See the [main repository](https://github.com/dvos-tools/autocut) for more information. 