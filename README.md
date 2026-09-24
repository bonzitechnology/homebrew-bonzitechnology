# homebrew-bonzitechnology

Homebrew tap for [Bonzi Technology](https://github.com/bonzitechnology) tools.

## Install

```sh
brew tap bonzitechnology/bonzitechnology
brew install ripcut
```

Or in one step:

```sh
brew install bonzitechnology/bonzitechnology/ripcut
```

## Formulae

| Formula | Description |
| --- | --- |
| [`ripcut`](Formula/ripcut.rb) | Fast drop-in replacement for `cut` with multi-character delimiter support |

## Updating a formula

Formula updates are **manual**. Nothing in this tap watches upstream, and the release
pipelines don't notify it, so a new upstream release does not reach users until the
formula is bumped here.

Note the failure mode is silent: the `url` lines are pinned to an exact tag, so until
you bump, `brew install` keeps installing the old version without any error. To check
whether a formula has fallen behind:

```sh
brew livecheck bonzitechnology/bonzitechnology/ripcut
# ripcut: 1.0.0 ==> 1.1.0
```

`livecheck` only reports — it never edits the formula.

### Bumping

Upstream's `release.yml` publishes one `<name>-<os>-<arch>` archive per platform, so
each formula pins four `url`/`sha256` pairs (darwin and linux × amd64 and arm64).
Don't edit these by hand — `bump-formula-pr` downloads every asset, computes the
checksums, and rewrites all eight lines:

```sh
brew tap bonzitechnology/bonzitechnology   # once, if not already tapped
brew bump-formula-pr --version=<new-version> bonzitechnology/bonzitechnology/ripcut
```

That opens a PR against this tap. Add `--write-only` to edit the formula in place
without committing or opening one.

Run this only after the release workflow has finished publishing its assets — the
command fetches them to hash, so it fails against a release that is still building.

### Verifying

```sh
brew style bonzitechnology/bonzitechnology/ripcut
brew audit --strict --online bonzitechnology/bonzitechnology/ripcut
brew install --force bonzitechnology/bonzitechnology/ripcut
brew test bonzitechnology/bonzitechnology/ripcut
```

`audit --strict` rejects a `version` line that duplicates the version already visible
in the `url`, which is why the formulae here spell the tag out in each URL rather than
interpolating a shared `version`.
