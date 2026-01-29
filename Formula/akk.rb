# akk Homebrew Formula
#
# Installation: brew install manwithacat/tap/akk
#
# This formula downloads pre-compiled binaries from GitHub releases.
# Binaries are built using `bun build --compile` in the akkadian repo CI.

class Akk < Formula
  desc "CLI for ML training workflows - Kaggle, Colab, MLflow integration"
  homepage "https://github.com/manwithacat/akkadian"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v1.2.0/akk-darwin-arm64.tar.gz"
      sha256 "6f688ba4466ada5f6c88b8cb04446171bd63abb244cfa01d56d4e1bb6e4764a7"
    end
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v1.2.0/akk-darwin-x64.tar.gz"
      sha256 "271502994952b1095efb00b9d773db4a812de4f61d8caa081c7c8f924b6129b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/manwithacat/akkadian/releases/download/akk-v1.2.0/akk-linux-x64.tar.gz"
      sha256 "57d103db7617a953e5a2a00dd1765eec7aee08c9516f50746e553e20ebc0662d"
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
