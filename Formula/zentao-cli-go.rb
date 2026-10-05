class ZentaoCliGo < Formula
  desc "Zentao CLI with comment support, profiles, and contract-tested server behavior"
  homepage "https://github.com/rioliu/zentao-cli-go"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.3/zentao-cli-go_v0.1.3_darwin_arm64.tar.gz"
      sha256 "a7d05b4e344294a89744894c854990e00cc4e1ef9f8e3f60184e0abfde8ff060"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.3/zentao-cli-go_v0.1.3_darwin_amd64.tar.gz"
      sha256 "9570416b291227d8bd5d064e44a10c9dc298e2abf50be8581f29a9b502811444"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.3/zentao-cli-go_v0.1.3_linux_arm64.tar.gz"
      sha256 "1255f255b9d965c5dafbe8a1d2d954a73a2da7444589dd0d0a490be19ea4618f"
    end
    on_intel do
      url "https://github.com/rioliu/zentao-cli-go/releases/download/v0.1.3/zentao-cli-go_v0.1.3_linux_amd64.tar.gz"
      sha256 "7ad077d0d5d56c1c254f82d1b9e2f7c0648a94f3ccae1f98c414ce3be928cfc8"
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
