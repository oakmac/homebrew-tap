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
  version "0.27.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.27.0/standard-clj-macos-aarch64"
      sha256 "1e7b35f12d9de5844a955d3d3a41d6fd6b57f1cd509018d6fd93065398b2b055"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.27.0/standard-clj-macos-x86_64"
      sha256 "5769162d733cd5f60dbd0acbc2c7b8ddf3dd0881b9f7ad991929c0bf90c52921"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.27.0/standard-clj-linux-aarch64"
      sha256 "00d66e12eed3cefb89326fba428375395ed30b37842239b90ca0714ea96c9b7a"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.27.0/standard-clj-linux-x86_64"
      sha256 "76a756735a0f487256c1862250754e223cb8d8f430bc743e42f55e793c229da3"
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