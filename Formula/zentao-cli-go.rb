class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.1/zentao-cli-go_v0.12.1_darwin_arm64.tar.gz"
      sha256 "a571e9e0bb420d0a846a1e2f0a27a50b7d36318c849cc2cd7a8407c8e0964391"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.1/zentao-cli-go_v0.12.1_darwin_amd64.tar.gz"
      sha256 "3b894e1c2196acef7bff7d0115e60edf62d3ac818c90e0974b35b3b479898734"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.1/zentao-cli-go_v0.12.1_linux_arm64.tar.gz"
      sha256 "106dfd1361e304f064a57d2f70884af6975438a5efd108b878250768402564c1"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.1/zentao-cli-go_v0.12.1_linux_amd64.tar.gz"
      sha256 "ee034cdee7c3cf91b8726192ed3fbe520f9c917f777a32437835b917e7a88cb6"
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
