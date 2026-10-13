# Generate Cabal files for every package.yaml, including the root package.
hpack:
    #!/usr/bin/env bash
    set -euo pipefail
    fd --hidden --no-ignore --exclude .git --type f '^package\.yaml$' . --print0 | while IFS= read -r -d '' package; do
        (cd "$(dirname "$package")" && hpack)
    done

# Generate Cabal files, then build all packages or a specific target.
build package="all": hpack
    cabal build {{quote(package)}}
