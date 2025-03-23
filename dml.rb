class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/dml"
  url "$JAR_URL"
  sha256 "$SHA256"
  license "Apache-2.0"

  def install
    libexec.install "DML-all.jar"
    (bin/"dml").write <<~EOS
      #!/bin/bash
      exec java -jar "\#{libexec}/DML-all.jar" "\$@"
    EOS
  end

  test do
    assert_match "DML Command Line Interface", shell_output("\#{bin}/dml help")
  end
end
