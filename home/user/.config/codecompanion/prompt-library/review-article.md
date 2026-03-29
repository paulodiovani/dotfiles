---
name: Review this article
interaction: chat
description: Review this blog post for typos, errors, or redundancy.
opts:
  alias: review-article
  auto_submit: true
  is_slash_cmd: true
  adapter:
    name: copilot
---

## user

#{buffer}

Review this blog post for:
- typos
- english semantic errors
- redundant sentences
- incorrect use of words

Then provide suggestions to fix or improve these issues.

Follow these rules:
- make small changes, words, not entire paragraphs
- do not change tone or writing style
- ignore the use of double dashes (`--`) for separation of sentences
- explain the changes.
