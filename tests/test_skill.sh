#!/bin/bash
# Test SKILL.md structure and constraints

echo "Testing SKILL.md..."

SKILL="$SKILL_DIR/SKILL.md"

assert_file_exists "$SKILL" "SKILL.md exists"
assert_line_count "$SKILL" 100 "SKILL.md ≤ 100 lines (token budget)"

# Frontmatter
assert_contains "$SKILL" "^name: obos" "has name in frontmatter"
assert_contains "$SKILL" "^description:" "has description in frontmatter"

# Command table completeness (9 commands)
assert_contains "$SKILL" "/obos init" "command table: init"
assert_contains "$SKILL" "/obos daily" "command table: daily"
assert_contains "$SKILL" "/obos save" "command table: save"
assert_contains "$SKILL" "/obos weekly" "command table: weekly"
assert_contains "$SKILL" "/obos sync" "command table: sync"
assert_contains "$SKILL" "/obos refine" "command table: refine"
assert_contains "$SKILL" "/obos ask" "command table: ask"
assert_contains "$SKILL" "/obos link" "command table: link"
assert_contains "$SKILL" "/obos draft" "command table: draft"

# Shared mechanisms present
assert_contains "$SKILL" "Vault Path Discovery" "has Vault Path Discovery section"
assert_contains "$SKILL" "Knowledge Maturity Model" "has maturity model"
assert_contains "$SKILL" "draft.*refined" "maturity: two levels (draft/refined)"
assert_contains "$SKILL" "Evergreen Note Template" "has Evergreen template"
assert_contains "$SKILL" "Command Routing" "has routing section"

# No duplicate command implementations
assert_not_contains "$SKILL" "^## /obos init" "no inline init implementation"
assert_not_contains "$SKILL" "^## /obos daily" "no inline daily implementation"
assert_not_contains "$SKILL" "^## /obos save" "no inline save implementation"
assert_not_contains "$SKILL" "^## /obos weekly" "no inline weekly implementation"
assert_not_contains "$SKILL" "^## /obos sync" "no inline sync implementation"
