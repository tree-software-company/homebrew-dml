class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/DML"
  url "https://github.com/tree-software-company/DML/releases/download/0.7.0/DML-all.jar"
  version "0.7.0"
  sha256 "b6ebe482558fdf3629aada5f521d1485d6f792c79bcf0ccb1c51c884113cde11"
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
