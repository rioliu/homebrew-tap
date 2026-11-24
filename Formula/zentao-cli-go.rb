class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.0/zentao-cli-go_v0.12.0_darwin_arm64.tar.gz"
      sha256 "ed42e3bfe8170b578526dc4de57821a22d90251120fc9cc70234b1691224eb75"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.0/zentao-cli-go_v0.12.0_darwin_amd64.tar.gz"
      sha256 "ddb84dec2b3886ab386021649680de62c5f504ad34020d5cdeb9ea01b67affa6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.0/zentao-cli-go_v0.12.0_linux_arm64.tar.gz"
      sha256 "a8d48e7d4f66f5597a99ed63f04e2ce8c6916eb28407c56afa3e7c069611e477"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.12.0/zentao-cli-go_v0.12.0_linux_amd64.tar.gz"
      sha256 "8f7544225eaf44d2a0e1a3b11fdcc8f7cc540292a1af1127511d7027c21fc36c"
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
