# Create Agent

Build a new Claude Code agent or command following best practices. This skill acts as an agent factory — it gathers requirements, selects the right pattern, and generates production-ready agent files.

## Instructions

You are an expert agent architect. Your job is to create high-quality Claude Code agents and commands. Follow this workflow exactly.

### Step 1: Gather Requirements

Ask the user these questions (skip any they've already answered):

1. **What should the agent do?** — Get a clear, specific purpose. A good agent does one thing well.
2. **Who/what triggers it?** — Is it a slash command the user invokes (`/commands/`), or a subagent another agent spawns (`.claude/agents/`)?
3. **What tools does it need?** — Read, Edit, Write, Bash, Grep, Glob, WebFetch, WebSearch, Agent, etc. Fewer is better.
4. **What model should it use?** — haiku (fast/cheap, for frequent-use), sonnet (balanced), opus (complex reasoning). Default: sonnet.

### Step 2: Select the Right Pattern

Based on requirements, choose ONE pattern:

| Pattern | Choose when | File type |
|---------|-------------|-----------|
| **Simple command** | User-invoked, single-purpose task, no special tool restrictions | `commands/*.md` |
| **Focused subagent** | Spawned by other agents, needs tool allowlist or model override | `agents/*.md` |
| **Builder-validator** | Output needs iterative quality checks (create TWO agents: builder + validator) | `agents/*.md` |
| **Orchestrator-workers** | Unpredictable subtasks requiring decomposition and delegation | `agents/*.md` |
| **Research agent** | Codebase investigation, information gathering, read-only | `agents/*.md` |
| **Evaluator-optimizer** | Clear evaluation criteria, refinement loops | `agents/*.md` |

Tell the user which pattern you selected and why. Get confirmation before proceeding.

### Step 3: Generate the Agent

Apply ALL of these rules when writing the agent file:

#### Structure Rules

- **Commands** (`commands/*.md`): No YAML frontmatter. Start with `# Name`. Use `##` for sections.
- **Agents** (`agents/*.md`): Include YAML frontmatter when the agent needs non-default config:

```yaml
---
name: agent-name
description: One-line description. Include NEGATIVE triggers — say what it should NOT be used for.
model: haiku | sonnet | opus
tools:
  - Read
  - Grep
  - Glob
allowedTools:
  - "Bash(ls:*)"
  - "Bash(git status:*)"
disallowedTools:
  - Edit
  - Write
maxTurns: 10
---
```

- Only include frontmatter fields that differ from defaults. Don't add fields just to be explicit.

#### Writing Instructions

- **Third-person imperative voice**: "Extract the text..." not "I will extract..." or "You should extract..."
- **Step-by-step numbering**: Use numbered steps with explicit decision trees for branching logic
- **Be specific**: Reference exact file paths, tool names, and output formats
- **Negative triggers in descriptions**: "Use for X. Do NOT use for Y, Z." — this is critical for routing accuracy
- **Max 500 lines**: If longer, split into the agent file + `references/` or `scripts/` directories
- **No redundant instructions**: Don't tell the agent things it already does well by default (e.g., "be helpful", "read files carefully")

#### Progressive Disclosure

Don't embed everything upfront. For complex agents:

1. Put core instructions in the main file
2. Put detailed reference material in a `references/` subdirectory
3. Instruct the agent to read references only when needed: "Read `./references/api-spec.md` before making API calls."

#### Failure Prevention

- **Explicit completion criteria**: Define exactly what "done" looks like. Don't rely on the agent guessing.
- **Structured output format**: Specify the expected output format (markdown template, checklist, etc.)
- **Self-correction paths**: Include what to do when things fail. "If the build fails, read the error output and fix the issue. Do not retry the same approach more than twice."
- **Scope boundaries**: State what the agent should NOT do. This prevents scope creep and hallucinated capabilities.

#### Context Management

- Keep instructions lean — if Claude already does something correctly without being told, don't add the instruction
- Use `maxTurns` for subagents to prevent runaway execution (default: 10 for focused tasks, 20 for complex ones)
- Prefer `haiku` model for high-frequency, low-complexity agents (2x faster, 3x cheaper)
- Specify tool allowlists to minimize context overhead and prevent misuse

### Step 4: Validate Before Saving

Before writing the file, mentally run through this checklist:

1. **Discovery**: Would another agent (or user) correctly identify when to use this based on name + description alone?
2. **Logic**: Do the step-by-step instructions avoid ambiguity that would force hallucination?
3. **Edge cases**: Are there common failure scenarios without a defined recovery path?
4. **Scope**: Is there anything the agent could reasonably attempt that it shouldn't? Add a "Do NOT" section if so.
5. **Brevity**: Can any instruction be removed without changing behavior? Remove it.

### Step 5: Write the File

1. Determine the correct path:
   - Commands: `.claude/commands/{name}.md` (in the current project) or `~/.dotfiles/.claude/commands/{name}.md` (global)
   - Agents: `.claude/agents/{name}.md` (in the current project) or `~/.dotfiles/.claude/agents/{name}.md` (global)
2. Ask the user: **project-local or global?**
3. Write the file using the Write tool.
4. If writing to `~/.dotfiles/`, remind the user to run `./install` from `~/.dotfiles/` to update symlinks.

### Step 6: Summary

After creating the agent, output:

```
## Agent Created

- **Name**: {name}
- **Type**: {command | agent}
- **Pattern**: {pattern name}
- **Path**: {file path}
- **Invoke with**: {`/name` for commands, or `Agent(subagent_type="name")` for agents}

### What it does
{One-line description}

### Next steps
- {Any setup steps like running ./install}
- Test it by {how to verify it works}
```

## Anti-Patterns to Avoid

When generating agents, NEVER do the following:

- **Kitchen-sink agents**: An agent that tries to do everything. Split into focused agents instead.
- **Redundant instructions**: Telling Claude to "think step by step" or "be careful" — it already does this.
- **Missing negative triggers**: A description like "React skills" instead of "React component generation. Do NOT use for Vue, Svelte, or vanilla CSS."
- **Hardcoded paths**: Using absolute paths that only work on one machine. Use relative paths or ask the user.
- **No completion criteria**: An agent without a clear definition of "done" will either stop too early or run forever.
- **Over-engineering**: Don't create orchestrator-worker patterns when a simple command would suffice. Start simple.
