class Dbq < Formula
  desc "Guarded multi-database query CLI with read-only credential profiles"
  homepage "https://github.com/rioliu/dbq"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.2/dbq_v0.2.2_darwin_arm64.tar.gz"
      sha256 "3a2ab602a9e41c766b305010c5b5c92a1369c76aa2ceade44ae2c441bdfe0222"
    end
    on_intel do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.2/dbq_v0.2.2_darwin_amd64.tar.gz"
      sha256 "a80ffde2f46975ec4058286bb4d334564bd7a0d1c9c1ac8a6b1e0503fd1ff146"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.2/dbq_v0.2.2_linux_arm64.tar.gz"
      sha256 "d0963bb377344b35b38111c04cba69319641ae9a4a6db8b6ea9b5552d87e3d17"
    end
    on_intel do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.2/dbq_v0.2.2_linux_amd64.tar.gz"
      sha256 "a10f0c1b874db0043c37609954635bd144fe702113b8ba0d749f61bbe9f47759"
    end
  end

  def install
    bin.install "dbq"
  end

  test do
    assert_match "dbq - multi-database", shell_output("#{bin}/dbq help")
    (testpath/"profiles.toml").write <<~EOS
      [profiles.test]
      type = 'sqlite'
      path = '#{testpath}/test.db'
      readonly = true
    EOS
    chmod 0600, testpath/"profiles.toml"
    ENV["DBQ_PROFILES"] = "#{testpath}/profiles.toml"
    assert_match "test", shell_output("#{bin}/dbq list")
  end
end
