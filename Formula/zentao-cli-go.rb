class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.1/zentao-cli-go_v0.1.1_darwin_arm64.tar.gz"
      sha256 "71e202cc20b6e4586f10d17126fad4cb0fcb77affcc4891f668238fdf4cbc3a0"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.1/zentao-cli-go_v0.1.1_darwin_amd64.tar.gz"
      sha256 "fa5226ecdc603d189aeec96f36f46af29ac5d5633304a32d22ad0018fd62fa0a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.1/zentao-cli-go_v0.1.1_linux_arm64.tar.gz"
      sha256 "9dcc3d456ed54cdba31fc519a272bfcac95b5b9d152016adec6e9bcceb052035"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.1/zentao-cli-go_v0.1.1_linux_amd64.tar.gz"
      sha256 "11da18805c94353bd5ee3405b45ab70d42ae344562aa8a844437845161f4744c"
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
