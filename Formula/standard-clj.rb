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
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest2/standard-clj-macos-aarch64"
      sha256 "9b8ed4e674e9ede0842dd99ed5b7cb201a566c435b76faafc56520215e1554aa"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest2/standard-clj-macos-x86_64"
      sha256 "a7223b37c864a0cbfad70f3d5513781ae7ecd181dab4a514ee769ea68f7157df"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest2/standard-clj-linux-aarch64"
      sha256 "55345b8bc7fa7c48dd92f364315fbecc89bb1dd1be8f5789d53ed12c9baf3e1e"
    else
      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/vtest2/standard-clj-linux-x86_64"
      sha256 "e1833b7a3de6c66e7ea93923c6202034626e098a91742a9eace32bd76f7bf490"
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