class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.14.0/zentao-cli-go_v0.14.0_darwin_arm64.tar.gz"
      sha256 "47e48f74a8890cca500938d9999388104a135392985a05615acb371e4126396d"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.14.0/zentao-cli-go_v0.14.0_darwin_amd64.tar.gz"
      sha256 "08b977ee016d426ed47b4eade6af31e7afd8e6f5f7e473abba221b0ee28d38c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.14.0/zentao-cli-go_v0.14.0_linux_arm64.tar.gz"
      sha256 "6ec81b74e9b13dc3ec300fa1f730a102323d4691b4611c8c62bc429e879cce37"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.14.0/zentao-cli-go_v0.14.0_linux_amd64.tar.gz"
      sha256 "462f73a64db6de04450260f86df1c255f6f6f47a7d927a2611551d4071028893"
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
