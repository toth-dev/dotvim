You can update submodules to the latest version, even if their remote has changed:

```bash
git submodule sync
git submodule foreach git checkout -f master
git submodule foreach git pull --rebase
```
