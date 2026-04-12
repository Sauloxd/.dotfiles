# Monthly Accounting Chores

Track and manage monthly accounting tasks that should be completed on the first business day of each month.

## Instructions

When invoked, do the following:

### Step 1: Determine the target month

- Check today's date
- The target month is the **current month** (chores are for the current month's first business day)
- Calculate the first business day (Mon-Fri) of the current month

### Step 2: Check or create the tracking file

- Tracking files live in `~/.dotfiles/finance/YEAR/YYYY_MM_DD.md` where the date is the **first business day** of the target month
- If the file exists, read it and show current status
- If it doesn't exist, create it from the checklist template below

### Step 3: Show status and ask what to do

Present the checklist with current completion status. Ask the user which items they want to mark as done, or if they want to add new items.

### Step 4: Update the file

Mark completed items with `[x]` and timestamp when they were done.

## Checklist Template

```markdown
# Accounting Chores - {MONTH YEAR}

First business day: {YYYY-MM-DD}

## Checklist

- [ ] Generate invoice, send to FOB, and generate NF
  - Copy from last invoice on wisePJ
  - Send invoice to: invoices@fob-solutions.com
  - Subject: "Invoice for {PREVIOUS_MONTH} {PREVIOUS_MONTH_YEAR} - FOB"
  - Generate NF and send to: atendimento.experts@contabilizei.com.br
- [ ] Send deel.com withdraw report
  - Send to: atendimento.experts@contabilizei.com.br
- [ ] Send nubank PJ bank statement
  - Also send rentability for "caixinha PJ"
- [ ] Send XP 20K reais
- [ ] Make sure there's enough money to pay apartment mortgage on bradesco
- [ ] Check pending things on contabilizei platform

## Notes

(Add any notes or observations here)
```

## Rules

- Always show the full checklist with current status when invoked
- When marking items done, add the completion date: `- [x] Item description (done YYYY-MM-DD)`
- If today is past the first business day, warn the user that chores are overdue
- If all items are checked, congratulate the user
- The user may add new chore items at any time - append them to the checklist
- Never delete chore items from the template, only add new ones
