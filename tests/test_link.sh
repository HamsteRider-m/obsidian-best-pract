#!/bin/bash
# Test link command file

echo "Testing link command..."

CMD="$SKILL_DIR/commands/link.md"

assert_file_exists "$CMD" "link.md exists"

assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"

# Key features per design doc §3.8
assert_contains "$CMD" -i "orphan\|孤岛\|孤立" "detects orphan notes"
assert_contains "$CMD" -i "reason\|理由" "provides reasons for link suggestions"
assert_contains "$CMD" -i "\[\[" "uses wikilink notation"
assert_contains "$CMD" -i "AskUserQuestion" "uses AskUserQuestion for confirmation"
assert_contains "$CMD" -i "\-\-all" "supports --all flag for vault-wide scan"
