class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.13.0/zentao-cli-go_v0.13.0_darwin_arm64.tar.gz"
      sha256 "864f9aee512f7c140e6b715282f037879204babd11bf1d698efba04618374d22"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.13.0/zentao-cli-go_v0.13.0_darwin_amd64.tar.gz"
      sha256 "8e68d53fc5a51d6d9f3750d411ed210e8afb9537327ac540f3caefc8a19480a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.13.0/zentao-cli-go_v0.13.0_linux_arm64.tar.gz"
      sha256 "af9f14fdc3ba3b9f413343c17169c422058aa19c6bd1c2f3b09010c738b4b06a"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.13.0/zentao-cli-go_v0.13.0_linux_amd64.tar.gz"
      sha256 "e8ceb41bfc8ae05f35ac14a60f3e19c41710e768dce8b37aee9eb67dd525f8cd"
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
