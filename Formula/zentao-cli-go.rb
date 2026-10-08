class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.0/zentao-cli-go_v0.6.0_darwin_arm64.tar.gz"
      sha256 "8e99f5a403b561afb5d98058510b99553cdf515dbc2ff37d6b09734dde59e3a5"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.0/zentao-cli-go_v0.6.0_darwin_amd64.tar.gz"
      sha256 "609b1f65c190350e4a710b67103687c1a6b6951bacabd1d492e251c1f645e7e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.0/zentao-cli-go_v0.6.0_linux_arm64.tar.gz"
      sha256 "17894e2789e24d04f40d28e498348045659f2c43db31985f5b58a262f1243880"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.6.0/zentao-cli-go_v0.6.0_linux_amd64.tar.gz"
      sha256 "6de3c22fe766dc02b47f8f8cc3574fd3006470895cf15a5171b1fdb2ffbfa06f"
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
