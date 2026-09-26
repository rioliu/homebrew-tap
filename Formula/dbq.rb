class Dbq < Formula
  desc "Guarded multi-database query CLI with read-only credential profiles"
  homepage "https://github.com/rioliu/dbq"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.0/dbq_v0.2.0_darwin_arm64.tar.gz"
      sha256 "96a0ecd49bd3e062c222d14d77045b7ac52a8716a5219e4dfdc89de09ac929aa"
    end
    on_intel do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.0/dbq_v0.2.0_darwin_amd64.tar.gz"
      sha256 "3278a26ec69349aced8d8add6c139393c5fb0eb3df602178c57a841d83e7149c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.0/dbq_v0.2.0_linux_arm64.tar.gz"
      sha256 "aff134a6f437d7f969f2d61f94c05858a3d3032c189401c04198c511f574bd8a"
    end
    on_intel do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.0/dbq_v0.2.0_linux_amd64.tar.gz"
      sha256 "e5d9f9430293728e8323ec57d6548d88d2a7d5f9373bfc28ffa045376e299b60"
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
