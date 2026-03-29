---
name: Add documentation to this code or function
interaction: chat
description: Create documentation for this code and update the buffer
opts:
  alias: document
  auto_submit: true
  is_slash_cmd: true
  adapter:
    name: copilot
tools:
  - insert_edit_into_file
---

## user

#{buffer}

Add documentation to the selected code or function.
Include argument and return types (but omit types for typescript).
Be succinct.
Do not add comments to variables or single line expressions.
