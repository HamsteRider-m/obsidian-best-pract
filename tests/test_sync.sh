#!/bin/bash
# Test sync command file

echo "Testing sync command..."

CMD="$SKILL_DIR/commands/sync.md"

assert_file_exists "$CMD" "sync.md exists"

assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"

# Key features per design doc §3.5
assert_contains "$CMD" -- "--status" "supports --status read-only mode"
assert_contains "$CMD" "Index.md" "updates Index.md"
assert_contains "$CMD" "CLAUDE.md" "updates CLAUDE.md"
assert_contains "$CMD" -i "Current Context" "CLAUDE.md boundary: only Current Context section"
assert_contains "$CMD" -i "health\|健康\|orphan\|broken" "includes health report"
