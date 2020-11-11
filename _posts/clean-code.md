Points:

- Production vs Staging ?
- How are new secrets created? Can one person see them?
- Should we be asking Snap Store to do an audit of the Snapcraft build system?
- Can we keep the same secret on prod, staging, demos?

Clean code:

- It's easier to fix well described code that doesn't work than working code that's hard to understand
- Reads like well-written code
- "Rude", "polite"
  Naming:
- "reads like well-written prose"
- Be brief
- Don't include types
- Use nouns
- Be accurate with singular and plural
- Don't abbreviate

Possibly worth considering:

- If anything can be extracted into a function, it should be
  - no if statements, booleans
- 3 arguments max
