class Dml < Formula
    desc "Custom DSL for data definition like JSON, with Kotlin & ANTLR"
    homepage "https://github.com/tree-software-company/DML"
    url "https://github.com/tree-software-company/DML/releases/download/0.1.0/DML-all.jar"
    sha256 "aa13858e5a234d666deb40820e9a2113a5e097792abef674e095a2c225801c10"
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
  