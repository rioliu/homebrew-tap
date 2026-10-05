class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.0/zentao-cli-go_v0.1.0_darwin_arm64.tar.gz"
      sha256 "faf49d7f8e7768268a80b37229793922ca6efe42e3c4970eb8d4b5ee711827ff"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.0/zentao-cli-go_v0.1.0_darwin_amd64.tar.gz"
      sha256 "5be369e53c0ab34cc84b743df231245dcaf8f158711618c4265cec25344c74f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.0/zentao-cli-go_v0.1.0_linux_arm64.tar.gz"
      sha256 "c56f78178ca001c1f547f164c9217b321da012cbba45173803eb67bf4962bbd5"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.0/zentao-cli-go_v0.1.0_linux_amd64.tar.gz"
      sha256 "1f11db454035c85f53e90072ffce57fa4ffee765732e57064c3700a0b64c5e48"
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
