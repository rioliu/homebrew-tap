class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.1/zentao-cli-go_v0.6.1_darwin_arm64.tar.gz"
      sha256 "a7d5413494363f01f3e1c8841b01c094342b2a21b3a380889531495c91d08d93"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.1/zentao-cli-go_v0.6.1_darwin_amd64.tar.gz"
      sha256 "5c46257182409f25a97a1fcfab6541aa5f7bac5474d488381cee5bf3bc812264"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.1/zentao-cli-go_v0.6.1_linux_arm64.tar.gz"
      sha256 "91f024389095e20f7fa15d8caff2dde97d26d29e66f4010880ffd52a82fd4fbb"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.1/zentao-cli-go_v0.6.1_linux_amd64.tar.gz"
      sha256 "bbb32f386778da74eeac3b4a015f0c32bf8470fff3d5ee393cba5139e6cc2533"
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
