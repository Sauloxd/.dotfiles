# Are We Done?

A pre-completion checklist to ensure work is truly finished.

## Instructions

Before marking any task as complete, run through this workflow:

### Step 1: Address Findings

If the reviewer identifies issues:
- **Blocking issues**: Fix immediately before proceeding
- **Cleanup recommended**: Fix now unless time-critical
- **Notes**: Document for future or address if quick

### Step 2: Verify It Works

Before committing, verify:
- [ ] Tests pass (run the test suite)
- [ ] Feature works as expected (manual verification if needed)

### Step 3: Clean Commit

Once verified, create a proper commit:
- Use conventional commit format
- Message reflects what was actually done
- All relevant files are staged

## Quick Checklist

Run through mentally:

- [ ] Did I remove all debug code?
- [ ] Did I update tests?
- [ ] Did I handle error cases?
- [ ] Did I clean up unused imports?
- [ ] Would I be comfortable if this went to prod right now?

## When to Use

Run `/arewedone` when:
- You think you've finished a feature
- Before creating a PR
- Before marking a task as complete
- When context-switching away from unfinished work (to capture state)
