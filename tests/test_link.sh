#!/bin/bash
# Test link command file

echo "Testing link command..."

CMD="$SKILL_DIR/commands/link.md"

assert_file_exists "$CMD" "link.md exists"

assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"

# Key features per design doc §3.8
assert_contains "$CMD" -i "suggest\|建议" "suggests links with reasons"
assert_contains "$CMD" -- "--all" "supports --all for full vault scan"
assert_contains "$CMD" -i "confirm\|确认" "user confirms each suggestion"
