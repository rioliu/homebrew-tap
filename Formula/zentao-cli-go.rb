class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.11.0/zentao-cli-go_v0.11.0_darwin_arm64.tar.gz"
      sha256 "374d5d4d9c9aeec0c505e72b11b9e2f6ee7556af4de55fc7b7e1908db4398606"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.11.0/zentao-cli-go_v0.11.0_darwin_amd64.tar.gz"
      sha256 "c2ff5b58d043754557b581dd4fd8120beaedcf2edbee7a73fba29674ac795bf9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.11.0/zentao-cli-go_v0.11.0_linux_arm64.tar.gz"
      sha256 "319efd55b3d2c42d17f68d10bca4a65e0edd69e346326163176fb883ca58817b"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.11.0/zentao-cli-go_v0.11.0_linux_amd64.tar.gz"
      sha256 "4d83059d40f6164e1a09b3023a0520a9ea3479274197523e20983916ec4006ce"
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
