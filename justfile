# Generate Cabal files for every package.yaml, including the root package.
[group('build')]
hpack:
    fd --hidden --no-ignore --exclude .git --type f '^package\.yaml$' . --exec hpack --force {}

# Generate Cabal files, then build all packages or a specific target.
[group('build')]
build package="all": hpack
    cabal build {{ quote(package) }}

# Format all Haskell files.
[group('format')]
fourmolu:
    fd --hidden --no-ignore --exclude .git --type f --extension hs . --exec-batch fourmolu --mode inplace

# Format all Nix files.
[group('format')]
nixfmt:
    fd --hidden --no-ignore --exclude .git --type f --extension nix . --exec-batch nixfmt

# Format the justfile.
[group('format')]
just-format:
    just --format

# Run all formatters.
[group('format')]
format: fourmolu nixfmt just-format

[group('lint')]
hlint:
    fd --hidden --no-ignore --exclude .git --type f --extension hs . --exec-batch hlint

[group('lint')]
nixfmt-check:
    fd --hidden --no-ignore --exclude .git --type f --extension nix . --exec-batch nixfmt --check

[group('lint')]
statix:
    statix check .

[group('lint')]
deadnix:
    deadnix --fail .

[group('lint')]
lint: hlint nixfmt-check statix deadnix
