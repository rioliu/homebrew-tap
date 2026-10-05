class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.3.0/zentao-cli-go_v0.3.0_darwin_arm64.tar.gz"
      sha256 "2c2b207b83d37b32e979d8e9a8110c7940c33cada3a92fb22449b9460fe8230c"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.3.0/zentao-cli-go_v0.3.0_darwin_amd64.tar.gz"
      sha256 "137f60a42bd04cf7d7e6558b347d87faf1f33eb87c73c3f4d8f0de04160a43d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.3.0/zentao-cli-go_v0.3.0_linux_arm64.tar.gz"
      sha256 "59cbcbac7e38801c6bb4cfcb0b6d60eb9b9bd9b2b0bab64a8b623a89e5b43d81"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.3.0/zentao-cli-go_v0.3.0_linux_amd64.tar.gz"
      sha256 "4485d3de7f3bcda4d3eff1ecc1c5e76bf8825e383992f38808ebac6b86d85c5e"
    end
  end

  def install
    bin.install "zentao"
  end

  test do
    assert_match "zentao - Zentao CLI", shell_output("#{bin}/zentao help")
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/zentao version"))
    assert_match "comment", shell_output("#{bin}/zentao help")
    (testpath/"profiles.json").write "{}"
    chmod 0600, testpath/"profiles.json"
    ENV["ZENTAO_PROFILES"] = "#{testpath}/profiles.json"
    assert_match "no profiles saved", shell_output("#{bin}/zentao profile")
  end
end
