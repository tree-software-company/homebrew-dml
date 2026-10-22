class Dml < Formula
  desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
  homepage "https://github.com/tree-software-company/DML"
  url "https://github.com/tree-software-company/DML/releases/download/0.8.1/DML-all.jar"
  sha256 "ce6ed0f4fbb277937812fef53a82526a55f1b0dcd2b4f4692c92cd81a45bd9fd"
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
    assert_match "DML version #{version}", shell_output("#{bin}/dml --version")
  end
end
