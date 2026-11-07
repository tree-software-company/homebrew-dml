# Security

This tap installs the DML CLI from a jar published on GitHub Releases. The formula `dml.rb` pins the release in its `url` and the jar in its `sha256`, so what matters is who is able to change those two lines and how that change can be checked.

## How a formula change reaches `main`

1. The jar `DML-all.jar` is built by the maintainer and published as a GitHub release of `tree-software-company/DML`.
2. Its SHA-256 is written to `.circleci/config.yml` in the DML repository through a reviewed pull request merged on GitHub.
3. The CircleCI job downloads the jar over TLS and stops unless the checksum matches the value from step 2.
4. The job pushes only a branch named `release/<version>` to this repository. It never pushes to `main`.
5. The maintainer compares `url` and `sha256` in the pull request with `.circleci/config.yml` in the DML repository and squash-merges on GitHub. The resulting commit on `main` is signed by GitHub.
6. Commits written by the maintainer by hand are signed with an SSH key.

No formula change is accepted on `main` without a Verified signature and a human comparing the hash.

## Verifying a commit

On GitHub, every commit on `main` made after this file was introduced shows the Verified badge.

To check locally:

```bash
git log --show-signature -5 main
```

- Commits merged on GitHub are signed with the GitHub web-flow key, published at `https://github.com/web-flow.gpg`.
- Commits written by the maintainer are signed with this SSH key:

```
SHA256:fOeiKl8Pmxv1wOuNwUHP+NEb9IFqoGAxBhoDb29bZvI (RSA 4096)
```

To verify them with `git`, take the public key from `https://api.github.com/users/simon04PL/ssh_signing_keys`, check with `ssh-keygen -lf` that its fingerprint equals the one above, write it to a file named `allowed_signers` in the form `<email> <key-type> <key>`, then:

```bash
git -c gpg.ssh.allowedSignersFile=allowed_signers verify-commit <commit>
```

## What is not covered

- Commits before this file was introduced are unsigned. History was not rewritten, because that would break existing installations of the tap.
- A compromised maintainer GitHub account or compromised signing key. Rotate the key and revoke it in GitHub settings if that happens.

## Maintainer settings on GitHub

These cannot be stored in the repository and have to be kept in place by hand:

- The SSH public key used for signing is added to the maintainer account as a Signing Key.
- `main` in this repository is protected by a ruleset: pull request required, signed commits required, force pushes and deletions blocked, empty bypass list.
- Squash merge is the only enabled merge method, because rebase merge cannot satisfy the signed commits rule.
- The deploy key used by CircleCI can push branches but is not on the bypass list of the `main` ruleset.
- In `tree-software-company/DML`, release immutability is enabled, so a published tag and its assets cannot be deleted or recreated with a different jar.
- Private vulnerability reporting is enabled for this repository.

## Reporting a vulnerability

Use Security → Report a vulnerability on this repository. Do not open a public issue for a suspected supply chain problem.
