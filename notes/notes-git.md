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

**How to determine the permissions of a file within a git repository?**

Sometimes there is a need to determine the permission on a file within a git repository.  The following
command can be used to determine the file permissions within the git repository.

```sh
$ git ls-files -s [<file>...]
100644 fe6f33163a3809c4f58bca6ec622abd7da126e8d 0       <file>
[...]
```

or use the --format command line option using the __objectmode__ field like the following

```sh
$ git ls-files --format='%(path) %(objectmode)' [<file>...]
100644 <file>
[...]
```

The first option will produce a list in which the file permission is part of the first six digits just
like the second option above.  The first three characters states the type of object, which in this case
it is 100 which is a regular file.  The next three characters state the type of permissions associated
to the selected file.

**How to update a files permission that exists within a git repository?**

There are times that one accidently stores a file within a git repository with the wrong permissions.
This is usually associated with files that should include the executable permission.  The following
command can be used to set a file executable permission bit.

```sh
$ git update-index --chmod=+x [<file>...]
```

While the above can be used to set the file executable bit.  There are cases that you need to remove
the executable bit.  This can be done as

```sh
$ git update-index --chmod=-x [<file>...]
```

As you must have noticed that the above examples are only updating a file executable permission bit.
The current version will only allow one to update the executable permission bit.



