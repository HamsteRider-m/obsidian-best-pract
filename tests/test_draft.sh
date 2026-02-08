#!/bin/bash
# Test draft command file

echo "Testing draft command..."

CMD="$SKILL_DIR/commands/draft.md"

assert_file_exists "$CMD" "draft.md exists"

assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"

# Key features per design doc §3.9
assert_contains "$CMD" -- "--assist" "supports --assist for AI drafting"
assert_contains "$CMD" -i "outline\|大纲" "default mode is outline"
assert_contains "$CMD" -i "search\|ask\|检索" "reuses search logic from ask"
