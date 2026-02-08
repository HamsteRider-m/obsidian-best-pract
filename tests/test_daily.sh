#!/bin/bash
# Test daily command file

echo "Testing daily command..."

CMD="$SKILL_DIR/commands/daily.md"

assert_file_exists "$CMD" "daily.md exists"

# Self-contained reference
assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"

# Key features per design doc §3.2
assert_contains "$CMD" -i "carry.forward\|未完成\|yesterday" "supports carry-forward from yesterday"
assert_contains "$CMD" -i "date\|YYYY-MM-DD\|yesterday" "supports date parameter"
assert_contains "$CMD" "Plan" "template has Plan section"
assert_contains "$CMD" "Log" "template has Log section"
assert_contains "$CMD" "Thoughts" "template has Thoughts section"
assert_contains "$CMD" "Meetings" "template has Meetings section"
