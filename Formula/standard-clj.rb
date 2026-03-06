class StandardClj < Formula
  desc "Formatter for Clojure code using Standard Clojure Style"
  homepage "https://github.com/oakmac/standard-clojure-style-binary"
  url "https://github.com/oakmac/standard-clojure-style-binary/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "8e1485940e53edd4670fa0f904a2e345dcad5e80489722307a7a2787c49a03f8"
  license "ISC"

  def install
    system "make"
    bin.install "standard-clj"
  end

  test do
    output = shell_output("echo '( ns foo )' | #{bin}/standard-clj fix -")
    assert_includes output, "(ns foo)"
  end
end
