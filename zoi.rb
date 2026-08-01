# Maintainer: ZilloweZ <zillowez@gmail.com>

class Zoi < Formula
  desc "Advanced Package Manager & Environment Orchestrator"
  homepage "https://gitlab.com/zillowe/zillwen/zusty/zoi"
  version "1.24.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-arm64.tar.zst"
      sha256 "cf689c7c2e104382efa608ce4f039cb22c7e5c80ad76e05e0cf9ab916aa8d84b"
    end

    if Hardware::CPU.intel?
      url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-macos-amd64.tar.zst"
      sha256 "d0c4b6287a0f1e7567eaed9ee694bae55c60ae354285a820b3fd43f2e1fc25af"
    end

    on_linux do
      if Hardware::CPU.intel? and Hardware::CPU.is_64_bit?
        url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-amd64.tar.zst"
        sha256 "aa524536f23c797a54030e13ad91284f816836e45fd7429ca37dfc90b33831eb"
      end

      if Hardware::CPU.arm? and Hardware::CPU.is_64_bit?
        url "https://gitlab.com/zillowe/zillwen/zusty/zoi/-/releases/Prod-Release-#{version}/downloads/zoi-linux-arm64.tar.zst"
        sha256 "57d3c657d918a01be18c9e4623adf57e1ccf32f44557f496151781f0b7a19464"
      end
    end

  end

  def install
    bin.install "zoi"
    (bash_completion/"zoi").write `#{bin}/zoi generate-completions bash`
    (zsh_completion/"_zoi").write `#{bin}/zoi generate-completions zsh`
    (fish_completion/"zoi.fish").write `#{bin}/zoi generate-completions fish`

    system "#{bin}/zoi", "generate-manual"
    man1.install Dir["manuals/*.1"]
  end
end
