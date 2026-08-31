class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/DML"
  url "https://github.com/tree-software-company/DML/releases/download/0.8.0/DML-all.jar"
  version "0.8.0"
  sha256 "04959ad5c6b4487dbbd6ecb9a1c14cc794e7754e348cec7c8b3b4e3b1ea80de1"
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
