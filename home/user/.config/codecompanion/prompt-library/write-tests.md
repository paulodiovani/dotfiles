---
name: Write tests for this file
interaction: chat
description: Write tests for this file or module following existing convention.
opts:
  alias: write-tests
  auto_submit: true
  is_slash_cmd: true
  adapter:
    name: copilot
---

## user

#{buffer}
@{full_stack_dev}

Write tests for this file or module.

Follow these additional rules:
- Check for existing tests under common paths, such as `test/`, `spec/`, or `src/**/*.test.*`.
- Follow conventions stablished by existing tests, if any.
- Write minimal tests, covering only the most common logic paths.
- Use mocks for external libraries.
- Do not install any new packages.
- Do not try to run the tests.
