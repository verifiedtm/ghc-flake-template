# GHC flake template

A Nix development shell with GHC, Cabal, Hpack, HLint, Fourmolu, and Just.

## Copy the template

```sh
git clone https://github.com/verifiedtm/ghc-flake-template.git my-project
cd my-project
rm -rf .git
git init
git add .
git commit -m "Initialize project from GHC flake template"
```

Replace `my-project` with your project name and rename the package and executable
in `package.yaml`.

## Development

```sh
nix develop
just build          # Build all packages; runs Hpack first
just build example  # Build a specific package
just hpack          # Generate Cabal files for all package.yaml files
cabal run example   # Run the example executable
```

Set `ghcVersion` in `flake.nix` to change GHC (`"984"` selects 9.8.4).
Nix requires the `nix-command` and `flakes` experimental features.
