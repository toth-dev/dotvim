# Table of Contents

- [Table of Contents](#table-of-contents)
- [Submodules](#submodules)
    - [Updating](#updating)
- [Public branch](#public-branch)

# Submodules


## Updating

You can update submodules to the latest version (even if their remote
address has changed) with these commands:

```bash
git submodule sync
git submodule update --remote --init
```

To fix broken submodule branches (HEAD detached), use:
```bash
git submodule foreach git checkout -f master
git submodule foreach git pull --rebase
```

If you don't want to update submodules on every fetch/pull (even when
there is a new commit referenced), put this in your `~/.gitconfig` or
`.git/config`:

```gitconfig
[fetch]
    recurseSubmodules = false
```

# Public branch

I want to publish the repository without its history, so I created
a `pub` orphan branch and update it:

```bash
git checkout --orphan pub
git commit -m"Inital commit"
git push -f origin pub

git checkout master
git branch -D pub
```
