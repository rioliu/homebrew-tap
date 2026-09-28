class Dbq < Formula
  desc "Guarded multi-database query CLI with read-only credential profiles"
  homepage "https://github.com/rioliu/dbq"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.1/dbq_v0.2.1_darwin_arm64.tar.gz"
      sha256 "949cbba383dbe8106f663c782e9039ccc849d9fab2978165b1655c0c0e1e87a5"
    end
    on_intel do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.1/dbq_v0.2.1_darwin_amd64.tar.gz"
      sha256 "d7964187eefe707f4fe00ed2f76064835a87ce154930d39d43db89fcffe7fd3b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.1/dbq_v0.2.1_linux_arm64.tar.gz"
      sha256 "600891ae954c3b05c35c6f9dc25e237c3bc5f50f62bc72f7c35a75d76076dc2e"
    end
    on_intel do
      url "https://github.com/rioliu/dbq/releases/download/v0.2.1/dbq_v0.2.1_linux_amd64.tar.gz"
      sha256 "a8594c852e0213ba1e356ea6346767931ad756aa8e95bc9f81cdc2e75d514aaa"
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
