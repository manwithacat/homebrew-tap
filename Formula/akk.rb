# akk Homebrew Formula
#
# Installation: brew install manwithacat/tap/akk
#
# This formula downloads pre-compiled binaries from GitHub releases.
# Binaries are built using `bun build --compile` in the akkadian repo CI.

class Akk < Formula
  desc "CLI for ML training workflows - Kaggle, Colab, MLflow integration"
  homepage "https://github.com/manwithacat/akkadian"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v0.1.0/akk-darwin-arm64.tar.gz"
      sha256 "d98c6515887452021b5bbff6853dc7e21d6edcf20d1b61cf8a217cee124ff232"
    end
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v0.1.0/akk-darwin-x64.tar.gz"
      sha256 "b25dd4a09dc24a914692abbb7d81907b4eefa1ecaa3ac6c081bc4ac9ab6af0ca"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v0.1.0/akk-linux-x64.tar.gz"
      sha256 "11eb301ce04cddddd088ddc179d3a4b047226ea6ef4457a38acb04545ba2f665"
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
