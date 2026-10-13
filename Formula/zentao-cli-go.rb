class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.0/zentao-cli-go_v0.10.0_darwin_arm64.tar.gz"
      sha256 "014d6abac08114da26756942ebb3689d75b4fc3b2b0a6b75d0f07e6a15e5b2fd"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.0/zentao-cli-go_v0.10.0_darwin_amd64.tar.gz"
      sha256 "317264fe87f925e6a395748777416923a24e083a8b824bdfa63e4c35d9ecbc98"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.0/zentao-cli-go_v0.10.0_linux_arm64.tar.gz"
      sha256 "c8de4733b389600d402e31d5e12ec8c93b1230460451f3ba811b1aa29385fe60"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.0/zentao-cli-go_v0.10.0_linux_amd64.tar.gz"
      sha256 "df5c194e215eec7d4c07010f993810a6c0249a8d4949fb057a1868383012f0f8"
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
