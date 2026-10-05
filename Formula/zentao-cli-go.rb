class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.2/zentao-cli-go_v0.1.2_darwin_arm64.tar.gz"
      sha256 "eafb444bf502653050ca684102a8dab2630203a9a28e2257e07f1572bbb0a6a8"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.2/zentao-cli-go_v0.1.2_darwin_amd64.tar.gz"
      sha256 "fd9ee27403e040fcb2d975c15a94a4cf0789c2d56c9dccf4ac630e29ff0def23"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.2/zentao-cli-go_v0.1.2_linux_arm64.tar.gz"
      sha256 "14112624ad4f5066ec87bace8983d2d5d95d0fd34fe0a17fb7a6a7f513761677"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.2/zentao-cli-go_v0.1.2_linux_amd64.tar.gz"
      sha256 "358eb61eaa36ea6de2e1c17133e1d50a6a60d42888dbe15466a8e16a7430d92e"
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
