class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.8.0/zentao-cli-go_v0.8.0_darwin_arm64.tar.gz"
      sha256 "0cdc672546192fe78a4b8362e202268548acb40e7fa0a21b396506933ec62698"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.8.0/zentao-cli-go_v0.8.0_darwin_amd64.tar.gz"
      sha256 "f4c1f913eb36743c54f172bbf400d6c6e5822db722e567018472c92989551617"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.8.0/zentao-cli-go_v0.8.0_linux_arm64.tar.gz"
      sha256 "8f3ffdab65e3836a4af68914b800d33651c3f7d0fc54497b20c13dcea84dab51"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.8.0/zentao-cli-go_v0.8.0_linux_amd64.tar.gz"
      sha256 "a5171f6332171a399cae2a0d114b3f0a9e02230486e048a27c32bd768cf17e2a"
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
