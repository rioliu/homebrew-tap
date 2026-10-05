class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.5/zentao-cli-go_v0.1.5_darwin_arm64.tar.gz"
      sha256 "e22e3fb3c37997144197cdb42ac2a34d2795cc8a52f047a80dc2d92296a98b9e"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.5/zentao-cli-go_v0.1.5_darwin_amd64.tar.gz"
      sha256 "06ec9d77752b417688a832fbe6522c08f0da703104957d67f21ba6f9e0f7748c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.5/zentao-cli-go_v0.1.5_linux_arm64.tar.gz"
      sha256 "0eb3ad08c703d6100768b43ecaf481ddce90bbe8cb978bdc61a4c1a7cbb33696"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.5/zentao-cli-go_v0.1.5_linux_amd64.tar.gz"
      sha256 "291b563b66d85455b1d3fa38dfd8d6b78965be0fd06453ed045cef0f4b4c6024"
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
