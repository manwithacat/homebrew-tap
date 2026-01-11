# akk Homebrew Formula
#
# Installation: brew install manwithacat/tap/akk
#
# This formula downloads pre-compiled binaries from GitHub releases.
# Binaries are built using `bun build --compile` in the akkadian repo CI.

class Akk < Formula
  desc "CLI for ML training workflows - Kaggle, Colab, MLflow integration"
  homepage "https://github.com/manwithacat/akkadian"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v1.1.0/akk-darwin-arm64.tar.gz"
      sha256 "e9b864b1f35c9b36f33e05889b2d700cb9a1eac3def161b59ec24bbcd3161b89"
    end
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v1.1.0/akk-darwin-x64.tar.gz"
      sha256 "92c7612d8068c5ae4055af6ea1a3c7551faa89ee88605262ac09a954cbfe9b6b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v1.1.0/akk-linux-x64.tar.gz"
      sha256 "0d6a9521f42a196cbcbbb19768779cda581981a1a81c17a81230518117d75abf"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "akk-darwin-arm64" => "akk"
      else
        bin.install "akk-darwin-x64" => "akk"
      end
    else
      bin.install "akk-linux-x64" => "akk"
    end
  end

  def caveats
    <<~EOS
      akk has been installed!

      Quick start:
        akk doctor                           # Check dependencies
        akk kaggle upload-notebook train.py  # Upload to Kaggle
        akk preflight check train.py         # Validate before deploy
        akk notebook build config.toml       # Generate from config

      MCP Server (Claude Code):
        Add to Claude Desktop config:
        {
          "mcpServers": {
            "akkadian": {
              "command": "#{HOMEBREW_PREFIX}/bin/akk",
              "args": ["mcp", "serve"]
            }
          }
        }

      Documentation:
        https://github.com/manwithacat/akkadian/tree/main/tools/akk-cli
    EOS
  end

  test do
    output = shell_output("#{bin}/akk version")
    assert_match "akk", output.downcase
  end
end
