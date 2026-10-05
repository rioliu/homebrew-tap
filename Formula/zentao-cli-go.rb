class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.4/zentao-cli-go_v0.1.4_darwin_arm64.tar.gz"
      sha256 "383c0b33db0f626611ac94d246923dd31c119a5f29ae915072ecc0bc74072833"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.4/zentao-cli-go_v0.1.4_darwin_amd64.tar.gz"
      sha256 "ced0ad5b24997fe1d17c852173c423325584e6ff30bb609eb1e1b667c7893c3c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.4/zentao-cli-go_v0.1.4_linux_arm64.tar.gz"
      sha256 "be5b79b6c00c177e86c8d61ee13d1564178f6249f611e92ba8196897be72a37b"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.4/zentao-cli-go_v0.1.4_linux_amd64.tar.gz"
      sha256 "63dc6c24454f88bb262a551cbf257d4b29d0c76fbb7b4a71bc6af25045583c43"
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
