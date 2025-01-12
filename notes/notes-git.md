---
title: Git
subtitle: Easily Forgotten Commands
author: Claudio Corsi
tags: [ Git ]
permalink: /notes/git/
debug: true
sidebar: notes-git
---

This page will contain different notes about Git that I find hard to recall.
The addition of adding these notes here will contain this information within a
single page. This will then greatly reduce the amount of time that will be needed
to find these commands.

**How to create a branch within a repository that references multiple remote repositories?**

The following command can be used to create a branche within a repository that
references multiple remote repositories.

```sh
$ git checkout -b <branch_name> <remote_repo>/<remote_branch>
$ git switch -b <branch_name> <remote_repo>/<remote_branch>
```

**How to push changes to a remote repository branch within a repository referencing multiple remote repositories?**

The following command can be used to push the current set of changes to the remote repository branch.

```sh
$ git push <remote_repo> HEAD:<branch>
```

The above command will push the current branch changes to the <remote_repo> repository to the <branch> branch.

