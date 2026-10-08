class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.7.0/zentao-cli-go_v0.7.0_darwin_arm64.tar.gz"
      sha256 "51ccb00ec0266cdecb455053e7b2fcc37119a0c27b9569c7958e6c76248aa5a8"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.7.0/zentao-cli-go_v0.7.0_darwin_amd64.tar.gz"
      sha256 "7397772a04db02a11a22354acacc91d3437444e57e7d9af0a371506be5963b5c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.7.0/zentao-cli-go_v0.7.0_linux_arm64.tar.gz"
      sha256 "dbf5a5a7c62edf5a70cf71aac087244150114b41a249b6d179b27171bdbc7a95"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.7.0/zentao-cli-go_v0.7.0_linux_amd64.tar.gz"
      sha256 "39ce2e84d2e72eaa93c3c22c785a5802ff289e6e309e72428fba0da284814b1c"
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
