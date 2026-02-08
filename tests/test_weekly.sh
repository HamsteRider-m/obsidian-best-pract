#!/bin/bash
# Test weekly command file

echo "Testing weekly command..."

CMD="$SKILL_DIR/commands/weekly.md"

assert_file_exists "$CMD" "weekly.md exists"

assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"

# Key features per design doc §3.4
assert_contains "$CMD" -- "--reflect" "supports --reflect flag"
assert_contains "$CMD" -i "quantit\|统计\|stats" "includes quantitative statistics"
assert_contains "$CMD" -i "last\|range\|week" "supports flexible date range"
assert_contains "$CMD" "Highlights" "template has Highlights"
assert_contains "$CMD" "Carry Forward" "template has Carry Forward"
