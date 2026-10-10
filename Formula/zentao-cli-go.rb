class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.9.0/zentao-cli-go_v0.9.0_darwin_arm64.tar.gz"
      sha256 "77e217243a91df930691294bed7b0289579974a2e13b60fd612273e6a9227c08"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.9.0/zentao-cli-go_v0.9.0_darwin_amd64.tar.gz"
      sha256 "6609a310424f75cd114ae8cf168b97eb18b505d4dcf3ecf2e103e104e085e210"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.9.0/zentao-cli-go_v0.9.0_linux_arm64.tar.gz"
      sha256 "5f30afdaece7ad06d9c0ba0af8195d232a2298f106e30348cedd2fd1c7f102a5"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.9.0/zentao-cli-go_v0.9.0_linux_amd64.tar.gz"
      sha256 "4ae00517484ada60a6e2841f52f179dc355a590d621677714a18a8338c1f8864"
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
