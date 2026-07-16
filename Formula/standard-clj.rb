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
  version "0.28.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.28.0/standard-clj-macos-aarch64"
      sha256 "a3982b51ceb3b5520f61787ff403e2024ee4a9513a2d5e50a3a2cc9571b84c9a"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.28.0/standard-clj-macos-x86_64"
      sha256 "78733ccbcf2775a91d10222b01069ec0b78f9e63adf2287cd637069105c5903e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.28.0/standard-clj-linux-aarch64"
      sha256 "764e099928c0276739eabd5ba61dde3280704325e8e2efcadc6629d79ff7feaa"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.28.0/standard-clj-linux-x86_64"
      sha256 "ca8bacc833ef87955d3cb1f44f8905e4877ebec4b9c22b30d052fcf0cacbdeb1"
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