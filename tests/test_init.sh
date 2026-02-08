#!/bin/bash
# Test init command file

echo "Testing init command..."

CMD="$SKILL_DIR/commands/init.md"

assert_file_exists "$CMD" "init.md exists"

# Self-contained: references SKILL.md shared logic, not duplicates it
assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"
assert_not_contains "$CMD" "Fallback.*OneDrive" "does not duplicate fallback path details"

# Key features per design doc §3.1
assert_contains "$CMD" -i "idempoten" "supports idempotent execution"
assert_contains "$CMD" -i "existing\|已有\|migrate\|detect" "handles existing vault detection"
assert_contains "$CMD" "AskUserQuestion" "uses AskUserQuestion for onboarding"
assert_contains "$CMD" "CLAUDE.md" "generates CLAUDE.md"
assert_contains "$CMD" "Index.md" "generates Index.md"
