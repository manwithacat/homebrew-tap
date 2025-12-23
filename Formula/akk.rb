# akk Homebrew Formula
#
# Installation: brew install manwithacat/tap/akk
#
# This formula downloads pre-compiled binaries from GitHub releases.
# Binaries are built using `bun build --compile` in the akkadian repo CI.

class Akk < Formula
  desc "CLI for ML training workflows - Kaggle, Colab, MLflow integration"
  homepage "https://github.com/manwithacat/akkadian"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v0.1.2/akk-darwin-arm64.tar.gz"
      sha256 "3a1138c09d1c9af0cb53806c610023e8134862cf6f4fe267ba9dd6986c29c3b8"
    end
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v0.1.2/akk-darwin-x64.tar.gz"
      sha256 "16a1b1d894d68528d53d9cb8fd8c34a7f4c3bb4702c7925921d31d814661f4d7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v0.1.2/akk-linux-x64.tar.gz"
      sha256 "79d86cdc8e47f6160f43528c25aa6ed912c1914975baa8c2c2dc4ae63beec8e8"
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
