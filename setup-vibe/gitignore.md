# .gitignore lines

Add each line only when absent. Extend for the stack once it is chosen.

```gitignore
.tmp/
test-results/
coverage/
dist/
.env.local
.env.*.local
```

If `.gitignore` contains a catch-all for hidden files such as `.*`, also add these exceptions after it:

```gitignore
!.gitignore
!.scratch/
!.env.example
```

`.scratch/` holds specs and tickets, and `.env.example` documents config; both must stay tracked.
