class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/DML"
  url "https://github.com/tree-software-company/DML/releases/download/0.2.0/DML-all.jar"
  version "0.2.0"
  sha256 "e186615a35aa60a5894f2e0171daeda76752d3a31c32b0122d726f3c5613e969"
  license "Apache-2.0"

  def install
    libexec.install "DML-all.jar"
    (bin/"dml").write <<~EOS
      #!/bin/bash
      exec java -jar "#{libexec}/DML-all.jar" "$@"
    EOS
  end

  test do
    assert_match "DML Command Line Interface", shell_output("\#{bin}/dml help")
  end
end
