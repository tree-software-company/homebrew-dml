class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/DML"
  url "https://github.com/tree-software-company/DML/releases/download/0.9.0/DML-all.jar"
  sha256 "e5f87380c03b5fb705a1b6357802a3a8f9b1273aed2e1346dd1332215cf3b677"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    libexec.install "DML-all.jar"
    (bin/"dml").write <<~EOS
      #!/bin/bash
      exec "#{formula_opt_bin("openjdk@17")}/java" -jar "#{libexec}/DML-all.jar" "$@"
    EOS
  end

  test do
    assert_match "DML version", shell_output("#{bin}/dml --version")
  end
end
