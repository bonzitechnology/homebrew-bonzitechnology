class Ripcut < Formula
  desc "Fast drop-in replacement for cut with multi-character delimiter support"
  homepage "https://github.com/bonzitechnology/ripcut"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/bonzitechnology/ripcut/releases/download/v1.0.0/ripcut-darwin-arm64.tar.gz"
      sha256 "cb7f9ec075c20e7a217c4aaab26990322e63411426b9cdb27356fbc6636c5dac"
    end

    on_intel do
      url "https://github.com/bonzitechnology/ripcut/releases/download/v1.0.0/ripcut-darwin-amd64.tar.gz"
      sha256 "234c2ec2aa3f00bf7c63b058e73a627c2aa0e06c74abad23463db3acade75e49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bonzitechnology/ripcut/releases/download/v1.0.0/ripcut-linux-arm64.tar.gz"
      sha256 "b572f6d66cb029a167b3ad06d7abeb280ad801b07a1a7b4eeee7a36eb74ac2ea"
    end

    on_intel do
      url "https://github.com/bonzitechnology/ripcut/releases/download/v1.0.0/ripcut-linux-amd64.tar.gz"
      sha256 "fdc726390b3ca15017f16b20fc8c03d9c04e9a9c1834adea593c880f41c58068"
    end
  end

  def install
    # The release pipeline ships the binary under its build triple, e.g.
    # ripcut-darwin-arm64, alongside README.md and LICENSE.
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.intel? ? "amd64" : "arm64"
    bin.install "ripcut-#{os}-#{arch}" => "ripcut"
  end

  test do
    # Multi-character delimiter plus field reordering: what ripcut adds over cut.
    assert_equal "three::one",
      pipe_output("#{bin}/ripcut -d '::' -f 3,1", "one::two::three\n", 0).chomp

    # Multi-character output delimiter.
    assert_equal "a | c",
      pipe_output("#{bin}/ripcut -d ',' -f 1,3 --output-delimiter=' | '", "a,b,c\n", 0).chomp

    # Character ranges behave like cut.
    assert_equal "hello",
      pipe_output("#{bin}/ripcut -c 1-5", "hello world\n", 0).chomp

    assert_match "ripcut", shell_output("#{bin}/ripcut --version")
  end
end
