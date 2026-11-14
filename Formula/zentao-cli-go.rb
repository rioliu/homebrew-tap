class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.1/zentao-cli-go_v0.10.1_darwin_arm64.tar.gz"
      sha256 "15a25e2c36d3d0fce21b083b03c138830a5802327bd9530fb3aca63c46ab85da"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.1/zentao-cli-go_v0.10.1_darwin_amd64.tar.gz"
      sha256 "d28f9574b40238318c42f42a1c4a136dc289a7a15e8b0b81a33076c05f0819c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.1/zentao-cli-go_v0.10.1_linux_arm64.tar.gz"
      sha256 "92c4b925c976f9863fbcdb8e32f61cf24d3030f9762e3cc7d336b52942934516"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.10.1/zentao-cli-go_v0.10.1_linux_amd64.tar.gz"
      sha256 "34f1abf36c6aef9e8864717005fce6367f2bcdd74e51fe8f77135b40acc5ab04"
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
