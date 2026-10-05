class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.0/zentao-cli-go_v0.2.0_darwin_arm64.tar.gz"
      sha256 "ce84bdd6a7a19860fe83d73763a4274cc15d51fa764bc5fab7872f8c1d795bb7"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.0/zentao-cli-go_v0.2.0_darwin_amd64.tar.gz"
      sha256 "9e04298a821ebe2db2d8c0c9211164a7b2ea0c9910977048d9edb067f6aeffe2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.0/zentao-cli-go_v0.2.0_linux_arm64.tar.gz"
      sha256 "8da6b243899af5bf32bb06b8115bafa67e0e6c28bc18fb4f712da66eecde24f9"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.2.0/zentao-cli-go_v0.2.0_linux_amd64.tar.gz"
      sha256 "e7accb177d77b5bb30715d7dca97371dc42f71f7d3bb11d90ccd9ed819633183"
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
