class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/dml"
  url "https://github.com/tree-software-company/DML/releases/download/0.1.0/DML-all.jar"
  version "0.1.0.1"
  sha256 "$SHA256"
  license "Apache-2.0"

  def install
    libexec.install "DML-all.jar"
    (bin/"dml").write <<~EOS
      #!/bin/bash
      exec java -jar "#{libexec}/DML-all.jar" "$@"
    EOS
  end

  test do
    assert_match "DML Command Line Interface", shell_output("#{bin}/dml help")
  end
end
