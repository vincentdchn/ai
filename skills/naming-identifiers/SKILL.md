---
name: naming-identifiers
description: Choose a name for a variable, function, type, or source file. Use for naming questions, naming audits, and safe identifier renames. Does not apply to branches, products, or skills.
---

# Naming identifiers

Read `rule://identifier-naming` first. If that URI is unavailable, read the [identifier naming rule](../../rules/identifier-naming.md). Use the [naming reference](reference.md) for verb meanings, naming patterns, and audit severities.

## Choose a name

1. Describe what the identifier holds or does in one sentence. If the sentence exposes independent responsibilities, consider splitting them before naming the result.
2. Check the project glossary. Search the code for the concept and likely synonyms, for example `rg -i 'supplier|vendor|provider'`.
3. Reuse the canonical term. If the glossary and existing usage cannot resolve competing terms, ask which term to use.
4. For an action function, pick a verb from the [verb table](reference.md#verbs) or the project's established vocabulary. Name the object unless the receiver supplies it.
5. Search for the candidate name. If the hits include a different concept, add a domain qualifier and search again.
6. Add a comment only when intent or a constraint is not clear from the name and type.

## Audit names

1. Use the files or diff the user names. If no scope is specified, review the branch diff from its merge base with the project base branch: `git diff <merge-base>...HEAD`.
2. Check added and changed names. Review a whole module only when the user asks for it.
3. Record at most one finding per identifier. Use the highest applicable severity in the [audit severity table](reference.md#audit-severities).
4. Report findings in severity order, highest first. Use one line per finding and keep the reason under ten words:

   ```text
   path:line  currentName -> proposedName  (Severity: reason)
   ```

5. End with the count at each severity. Flag proposals that rename an exported symbol and need a call-site check.

Do not edit code during an audit unless the user authorizes a rename.

## Rename a symbol

Use the progression from Arlo Belshee's [Naming as a Process](https://www.digdeeproots.com/articles/naming-process/naming-as-a-process) to reason about the name. Start at the stage that describes the current code. The stages do not require separate edits or commits.

1. **Missing to nonsense.** Give an unnamed operation a working name in your draft.
2. **Nonsense to honest.** Name one thing the operation actually does.
3. **Honest to complete.** Account for the behavior a caller must know, including side effects. If the name exposes independent responsibilities, propose a split separately from the rename.
4. **Complete to intent.** Name why the caller uses the operation, not how it works.
5. **Intent to domain.** Use the project's term for that intent.

Apply the rename in one coherent change:

- Check references with the language server before renaming an exported symbol. Use the language server's rename operation for symbols. Use text edits for string references, docs, and configuration.
- Rename a file named after the symbol, and update imports and path references.
- Remove obsolete internal names in the same change. For a published API, follow the project's compatibility policy. Keep a deprecation alias only if that policy calls for one.
- Search for the old name. Resolve obsolete references and distinguish unrelated hits or intentionally retained compatibility references.
- Run the project's type check when available, and the narrowest check that exercises the affected callers. Keep behavior changes out of the rename.
