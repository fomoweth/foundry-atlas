# Update the bundled chain configuration.
fetch-chains:
    #!/usr/bin/env bash
    set -euo pipefail
    tmp="$(mktemp chains.json.XXXXXX)"
    trap 'rm -f "$tmp"' EXIT
    curl -fsSL https://raw.githubusercontent.com/alloy-rs/chains/refs/heads/main/assets/chains.json -o "$tmp"
    node --input-type=module - "$tmp" <<'JS'
    import { readFileSync, writeFileSync } from "node:fs";
    const file = process.argv[2];
    const { chains } = JSON.parse(readFileSync(file, "utf-8"));
    if (!chains || typeof chains !== "object" || Array.isArray(chains)) {
      throw new Error("Expected a top-level chains object");
    }
    writeFileSync(file, JSON.stringify(chains, null, 2) + "\n");
    JS
    mv "$tmp" chains.json
    echo "Updated chains.json"
