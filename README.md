# oakmac homebrew-tap

Homebrew formulae for [standard-clj](https://github.com/oakmac/standard-clojure-style-binary).

## Users

```sh
brew tap oakmac/tap
brew install standard-clj
```

---

## Maintainer: How to Release a New Version

You will forget this. That's OK. Here are the steps.

### 1. Tag the release in the main repo

```sh
cd ~/path/to/standard-clojure-style-binary
git tag v0.0.2
git push --tags
```

### 2. Wait for GitHub Actions to finish

Go to https://github.com/oakmac/standard-clojure-style-binary/actions and
wait for the Release workflow to go green. It builds binaries for all platforms
and creates a GitHub Release.

### 3. Copy the SHA256 from the release

Open the new release on GitHub. The release notes include a line like:

```
Source tarball SHA256: abc123def456...
```

Copy that hash.

### 4. Update the formula

```sh
cd ~/path/to/homebrew-tap
```

Edit `Formula/standard-clj.rb`:
- Change the version in the `url` line (e.g. `v0.0.1` → `v0.0.2`)
- Paste the new SHA256 into the `sha256` line

```ruby
url "https://github.com/oakmac/standard-clojure-style-binary/archive/refs/tags/v0.0.2.tar.gz"
sha256 "paste_the_sha256_here"
```

### 5. Push

```sh
git add Formula/standard-clj.rb
git commit -m "standard-clj v0.0.2"
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