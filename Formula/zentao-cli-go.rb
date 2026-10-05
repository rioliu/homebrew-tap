class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.4.0/zentao-cli-go_v0.4.0_darwin_arm64.tar.gz"
      sha256 "250dd9483af4c4a938fe41cff19927b398df741d5369fa812c51b0f962f6df91"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.4.0/zentao-cli-go_v0.4.0_darwin_amd64.tar.gz"
      sha256 "28c893f792aba23b09c13a634c500929c27c1f8bab12727355025dfec56766ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.4.0/zentao-cli-go_v0.4.0_linux_arm64.tar.gz"
      sha256 "c3646350fec09b18e88ce9f5fdd56f921b740ce7921072b7b9ad333d64267f4a"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.4.0/zentao-cli-go_v0.4.0_linux_amd64.tar.gz"
      sha256 "4c5b7528d0ec9a04252d22692bf0c90fb5975b320d9bc72e71c9cf6348750f43"
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
