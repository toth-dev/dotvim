You can update submodules to the latest version (even if their remote has changed) with these commands:

```bash
git submodule sync
git submodule update --remote --init --recursive
```

To fix broken submodule branches (HEAD detached), use:
```bash
git submodule foreach git checkout -f master
git submodule foreach git pull --rebase
```
