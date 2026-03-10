# oakmac homebrew-tap

Homebrew formulae for [standard-clj](https://github.com/oakmac/standard-clojure-style-js).

## Users

```sh
brew tap oakmac/tap
brew install standard-clj
```

---

## Maintainer: How to Release a New Version

This documents the release process for publishing a new version of the Homebrew formula.

### Background

The `standard-clj` binary is built from the [standard-clojure-style-js] repo.
The Release workflow in that repo uses [Bun's cross-compilation][bun-compile]
to produce self-contained binaries for 5 platforms (macOS arm64/x86_64,
Linux arm64/x86_64, Windows x86_64) from a single Linux runner. This formula
downloads the correct pre-built binary for the user's platform.

[standard-clojure-style-js]: https://github.com/oakmac/standard-clojure-style-js
[bun-compile]: https://bun.sh/docs/bundler/executables

### 1. Tag the release in the JS repo

```sh
cd ~/path/to/standard-clojure-style-js
git tag v1.1.0
git push --tags
```

### 2. Wait for GitHub Actions to finish

Go to https://github.com/oakmac/standard-clojure-style-js/actions and wait
for the **Release** workflow to go green. It will:
- Run lint + tests
- Build binaries for all 5 platforms using Bun cross-compilation
- Create a GitHub Release with the binaries attached

### 3. Copy the SHA256 values from the release

Open the new release on GitHub. The release notes include a section like:

```
SHA256 Checksums (for Homebrew formula update)

standard-clj-linux-x86_64:        abc123...
standard-clj-linux-aarch64:       def456...
standard-clj-macos-aarch64:       789ghi...
standard-clj-macos-x86_64:        jkl012...
standard-clj-windows-x86_64.exe:  mno345...
```

You need the 4 non-Windows hashes for the formula.

### 4. Update the formula

```sh
cd ~/path/to/homebrew-tap
```

Edit `Formula/standard-clj.rb`. You need to update **three things**:

1. The `version` line at the top
2. The version in each `url` line (appears 4 times — macOS arm64, macOS x86_64, Linux arm64, Linux x86_64)
3. The `sha256` line below each `url` (4 values total)

Example diff for going from v1.0.0 to v1.1.0:

```diff
-  version "1.0.0"
+  version "1.1.0"

   on_macos do
     if Hardware::CPU.arm?
-      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v1.0.0/standard-clj-macos-aarch64"
-      sha256 "old_hash_here"
+      url "https://github.com/oakmac/standard-clojure-style-js/releases/download/v1.1.0/standard-clj-macos-aarch64"
+      sha256 "new_hash_here"
```

Repeat for all 4 platform blocks.

### 5. Push

```sh
git add Formula/standard-clj.rb
git commit -m "standard-clj v1.1.0"
git push
```

### 6. Test it

```sh
brew update
brew upgrade standard-clj
# or if not installed yet:
brew install oakmac/tap/standard-clj
```

That's it. Five minutes, tops.

---

## How It All Fits Together (the big picture)

There are three repos involved:

| Repo | What it does |
|------|-------------|
| [standard-clojure-style-js] | The formatter library + CLI. Has CI (lint/test on every push) and a Release workflow (builds binaries on tagged pushes). This is the **source of truth**. |
| [homebrew-tap] (this repo) | Contains the Homebrew formula. Points to pre-built binaries from the JS repo's GitHub Releases. Updated manually after each release. |
| [standard-clojure-style-binary] | The old C + Lua approach. **Archived / reference only.** Slower than the Bun binaries. Ignore this repo. |

The flow is: tag JS repo → CI builds binaries → update this formula → users get new version via `brew upgrade`.

[standard-clojure-style-js]: https://github.com/oakmac/standard-clojure-style-js
[homebrew-tap]: https://github.com/oakmac/homebrew-tap
[standard-clojure-style-binary]: https://github.com/oakmac/standard-clojure-style-binary