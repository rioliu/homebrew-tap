class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.5.0/zentao-cli-go_v0.5.0_darwin_arm64.tar.gz"
      sha256 "a253020cb1b5ef65b1b6978b1d2ac1ed692065d030b6a23793704ed6b92d1542"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.5.0/zentao-cli-go_v0.5.0_darwin_amd64.tar.gz"
      sha256 "d6da504987e2a86da89940bd1d7f1fd53e6b935f09c9efd065c0d7ae059ce340"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.5.0/zentao-cli-go_v0.5.0_linux_arm64.tar.gz"
      sha256 "62a4fe86dd423454d7998575575e5697b2dd02c87f5b2df913bad999ad41ed98"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.5.0/zentao-cli-go_v0.5.0_linux_amd64.tar.gz"
      sha256 "113ef58bcb42f5ef9ce41207c62f52d210ea693b992c8df98090c01d4b4f477c"
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
