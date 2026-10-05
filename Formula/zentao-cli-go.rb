class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.1/zentao-cli-go_v0.2.1_darwin_arm64.tar.gz"
      sha256 "d934384c4441e96722a1f5199e74d6acdc695b277575e0501a2e8e39d23645bf"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.1/zentao-cli-go_v0.2.1_darwin_amd64.tar.gz"
      sha256 "02f2075fcb929dab9031a9a0bd128ae84a6cb1f4a15bc948c17eaef53d649ca9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.1/zentao-cli-go_v0.2.1_linux_arm64.tar.gz"
      sha256 "5fe0fdeb225d274d8907af0e9cb8df7f5b04b11110867bf0ff9b3269573ad71c"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.1/zentao-cli-go_v0.2.1_linux_amd64.tar.gz"
      sha256 "1ce1ee32b9b722bfe6378efc326dc36214a8a873511d8bc57d79fe45d263db4c"
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
