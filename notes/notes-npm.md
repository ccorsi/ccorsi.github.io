---
title: NPM
subtitle: Commands FAQ
author: Claudio Corsi
tags: [ npm ]
permalink: /notes/npm/
debug: true
sidebar: notes-npm
---

This page contains FAQ notes using the npm command line tool. The following commands will
describe different commands that I deem useful but that are not usually used by myself. It
is hoped that this information will allow me to be able to reduce the amount of time
required to be able to gather and execute the required commands.

While these sets of FAQ type questions here will contain information. We can always
reference the current documentations on the npm command tool at 
[NPM Documentation](https://docs.npmjs.com/about-npm).

### How to determine which packages are being using for a given Node Project

While you can determine what packages are being used by your project.  It is possible
that some projects are attached to your project that are not part of the list of
dependencies within the package.json file.  These packages will be linked using the
npm link command which is discussed next.  Thus, if you want to know which packages
are being used within the current project.  You then execute the following command.

```sh
$ npm ls
<project-name>@<project-version> <local-package-top-directory>
├── @types/jest@30.0.0
├── @types/node@25.3.2
├── jest@30.2.0
├── ts-jest-resolver@2.0.1
├── ts-jest@29.4.6
└── typescript@5.9.3
```

Where the <project-name> and <project-version> is the name and version entry within the
local project package.json file.  While the <local-package-top-directory> is the root
directory of the local package being used by this project.

When is this command useful?  This becomes useful whenever you are looking to update
the current set of local projects that are going to be used by your project.

### How to Link Local Package to a local Node Project

This can become an issue when you are developing a project that you want to use packages
that are not available within the npm package manager.  This can be because you are
developing the dependent package or that the package is private to your company.
You can then get around this issue by linking those packages to your local project using
the [npm link command](https://docs.npmjs.com/cli/v11/commands/npm-link).

This is when the value of this command becomes useful.  While the command is fairly
simple to use, for example.

```sh
$ npm link <local-project-root-directory>
```

The above command will then add the local project to the current project.  While this is a
simple enough step there is something that you need to keep in mind.  If the above command
is the only local project added to the local project then there is no issues.  The issue
is when you want to add another link or remove one.  This case requires that you need to
reset all of the local package links within a single command line.  You will not be able
to add a single link to the current set of links.  It is possible that the addition of a
linked project will remove the priorly linked projects.  Thus, you will initially need
to be execute the **npm ls** command prior to executing the **npm link** command.  For
example.

```sh
$ npm ls
<project-name-1>@<project-version-1> <project-top-level-directory-1>
...
<project-name-n>@<project-version-n> <project-top-level-directory-n>
...
$ npm link <project-top-level-directory-1> ... <project-top-level-directory-n> <project-top-level-directory-n+1
```

The above steps is just determing all of the currently linked local projects and then those
projects are included as part of the npm link command with the newly added local projects.
The above is also used in the case that one is looking to remove any local project links.

### How to update all of the global and/or project packages

There are times that you want to be able to upgrade the current set of global libraries
associated to the current Node installation.  This is done using the following command.

```sh
$ npm upgrade -g
```

This above command will upgrade all global packages that are currently not up to date.
Note that the above command is not related to updating the packages associated with
the current project.  To update the current project packages you need to execute the
following command.

```sh
$ npm upgrade
```

The above command will upgrade all of the current project packages to their latest
versions.

### How to remove extraneous packages from your project

While upgrading your package dependencies is always something that can be happening on
a regular basis.  This action will cause you to include version of packages that are
not being used because of newer versions being installed.  This is then causing you
to use extra space that is not required.  There is a command that can then be used
to remove, prune, those extraneous version packages from your local system.  This is
done by executing the following command.

```sh
$ npm prune
```

The above command will then remove all extraneous packages that are not being used
by your project any longer.


