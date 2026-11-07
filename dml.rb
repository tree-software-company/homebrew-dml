class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/DML"
  url "https://github.com/tree-software-company/DML/releases/download/0.8.2/DML-all.jar"
  sha256 "e0167be1b1063455d74cb5fdf9c44cd320692a30b39b47f369cbc00e8bac07a1"
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
