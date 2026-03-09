# Homebrew formula for Standard Clojure Style
#
# This downloads a pre-built binary from the standard-clojure-style-js GitHub Releases.
# The binaries are compiled from JavaScript using Bun and are fully self-contained
# (no runtime dependencies).
#
# To update this formula for a new release:
#   1. Tag and push in the standard-clojure-style-js repo
#   2. Wait for the Release workflow to finish
#   3. Copy the SHA256 values from the GitHub Release notes into this file
#   4. Update the version number in every url line
#   5. Push this repo
#
# See README.md for the full step-by-step checklist.

class StandardClj < Formula
  desc "Formatter for Clojure code using Standard Clojure Style"
  homepage "https://github.com/oakmac/standard-clojure-style-js"
  license "ISC"
  version "0.0.13-test"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest3/standard-clj-macos-aarch64"
      sha256 "0c3433cc9e13215374c69d18030df2512085b1afdb4b67062a4eba6ad9e75242"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest3/standard-clj-macos-x86_64"
      sha256 "94dfe821a168c6039a939d778658b95310e6ffa52d0070670379fd3b9d925971"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest3/standard-clj-linux-aarch64"
      sha256 "2cfa798b78fb8a95c184e2b8eaf191edd26077e9fb7ed6a597b8211a8dedd2a9"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest3/standard-clj-linux-x86_64"
      sha256 "19b580bf504d1b844d2563256cd1e9ef1d4f9bd2790b12781079635b9d46fa23"
    end
  end

  def install
    # The downloaded file is already a compiled binary — just install it
    binary_name = Dir.glob("standard-clj-*").first
    mv binary_name, "standard-clj"
    chmod 0755, "standard-clj"
    bin.install "standard-clj"
  end

  test do
    output = shell_output("echo '( ns foo )' | #{bin}/standard-clj fix -")
    assert_includes output, "(ns foo)"
  end
end