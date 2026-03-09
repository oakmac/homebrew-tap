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
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v1.0.0/standard-clj-macos-aarch64"
      sha256 "b31814c23a61f6ac2c8238ef528f6dbf3eb313be61e515568726d967eed21b6e"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v1.0.0/standard-clj-macos-x86_64"
      sha256 "6eb75b873f6878ac0f1bf5e5cabddbbb8baa0f7c82edcb796d3a7b1da341bf4d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v1.0.0/standard-clj-linux-aarch64"
      sha256 "51c82a9f08f066a76218627b943ae20219ff720afe8fe94d21357aa4657f1602"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v1.0.0/standard-clj-linux-x86_64"
      sha256 "90d5d98c2f98a9409b2692ff592506d5f19fe8b6585bc0f577f4e22e2520312b"
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