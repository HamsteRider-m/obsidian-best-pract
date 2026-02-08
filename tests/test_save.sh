#!/bin/bash
# Test save command file

echo "Testing save command..."

CMD="$SKILL_DIR/commands/save.md"

assert_file_exists "$CMD" "save.md exists"

# Self-contained reference
assert_contains "$CMD" "Vault Path Discovery" "references shared Vault Path Discovery"

# Key features per design doc §3.3
assert_contains "$CMD" -i "evergreen" "supports evergreen type"
assert_contains "$CMD" -i "daily" "supports daily type"
assert_contains "$CMD" -i "clip" "supports clip type"
assert_contains "$CMD" -i "meeting" "supports meeting type"
assert_contains "$CMD" -- "--deep" "supports --deep flag for guided mode"
assert_contains "$CMD" -i "draft\|refined" "references maturity model"
assert_contains "$CMD" -i "frontmatter\|status:" "uses frontmatter for maturity"
