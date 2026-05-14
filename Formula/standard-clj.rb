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
      sha256 "9290f8c5b2899bcd9e10b4e6554dc37859a24f5a21e0c62bc17d5e11acb14db7"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.28.0/standard-clj-macos-x86_64"
      sha256 "875f3507a14c8ed2fc06db05d8f4c8400e54a30e701c41cce1a2d6c683b86161"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.28.0/standard-clj-linux-aarch64"
      sha256 "9a1d6554c577f95fb70b72a5fbfe87d3ea1d05194664b15408cd13d3c93e7510"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v0.28.0/standard-clj-linux-x86_64"
      sha256 "4ab58b4e69605ff6f99a90088845b26e781b968ee0ce84478a85df41d239680e"
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