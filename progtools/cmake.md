---
title: CMake
subtitle: Some Useful Pointers
sidebar: progtools-cpp
---

I have started to use *CMake* to build several of my C++ projects.  While this is a great way for me to be able to gain this
knowledge it has also occurred to me that there are some things that I use infrequently to be able to remember for next time.
I have thus created this simple page to include the different features that I have used from CMake that I'll need to remind
me of.  I hope that this information will also be beneficial to others that have started to use or have been using CMake for
awhile.  Without further ado let us begin with some general information.

## CMakeList.txt

Well, the first thing that we all need to do when using CMake is to create the required CMakeLists.txt file that contains all
of the files that need to be built.  There are some features that I seem to forget everytime I create one that I will mention
in the following sections.

### Header

The first thing that all CMakeLists.txt needs is a primary header detail that is mandatory for all CMake projects.  Here is what
the file should then initially look like:

```cmake
# Demand that you use a minimum version of CMake since some tools require this like GoogleTest
cmake_minimum_required(VERSION 3.10.0)

# Name the project you are building and associate a version to it
project(<project_name> VERSION 0.0.1)

# This is required to be able to have cmake generate the required test build files
enable_testing()

# This is required to be able to have cmake generate the required package files
include(CPack)

```

The above is a good start for creating a CMake project.  The minimum CMake version requirement can be useful when using third party
libraries that force the use of a minimum version.  While enabling testing and including the CPack packages are useful in and of 
themselves.  Let us then leave the above as is and move on to other parts of the CMake CMakeLists.txt file.

### Configuration

While CMake is a great tool to use to be able to build multi-platform executables.  It does have some key features that one needs to
remember to be able to get their project built, tested and package properly.  Here we will point out some features that need to be
managed properly to be able to successfully generate a succesful CMake project.

When one creates a CMake project, we start by creating a CMakeLists.txt file.  This file will initially include one or more source file
that we build and test against.  When our project starts to grow we realize that we should divide our project into different modules
that perform different tasks that are then combined.  We then create a top-level CMakeLists.txt file that then uses the
[add\_subdirectory](https://cmake.org/cmake/help/latest/command/add_subdirectory.html){:target="_blank"} function to include the
different modules to be built.  As part of this we also include some general settings that are required and any external libraries
that are needed by the build.  For instance, we can create the following top-level CMakeLists.txt that includes the need for
GoogleTests to be able to build and test our project.

```cmake
# Define the minimum cmake version and project name and version
cmake_minimum_required(VERSION 3.25.0)
project(sample VERSION 0.1.0)

# setup the minimum C++ requirements
set(CXX_STANDARD 17)
set(CXX_STANDARD_REQUIRED true)

# needed to be able to fetch the required GoogleTests sources for this project
include(FetchContent)

# To be able to use google test framework we need to fetch the source code that will be used to build
# and run this projects tests using google test framework.
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG main
)

# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(googletest)

# add the different sub-projects to this build
add_subdirectory(utils)
add_subdirectory(...)
...
```

As you can see this looks like a pretty innocent CMakeLists.txt file that one would expect to be able to build, test and package your
project.  This change can be applied by someone within the group and when they execute cmake, ctest and cpack everything is expected
to be built, tested and packaged.  They then go to commit and push this up to their SCM server.  When the CI/CD kicks off it fails
by stating that it was not able to find any test files.  Well, you might be wondering why is this the case all of a sudden.  Well,
the reason is that we need to include the
[enable_testing](https://cmake.org/cmake/help/latest/command/enable_testing.html){:target="_blank"} call to be able to generate
the required testing builds.  You would also need to include the CPack to be able to generate the required package build files.
You then need to add the following lines to the top-level CMakeLists.txt file.

```cmake
# This is required to be able to generate the test build
enable_testing()

# This is required to be able to generate the CPack build
include(CPack)
```

Adding the above to the top-level CMakeLists.txt file will insure that the required build files are generated.  We can then
successfully use the ctest and cpack commands.

**NOTE:** you need to include the *enable_testing* call within every CMakeLists.txt file and its parent to correctly generate
the required test build files to be able to run the tests associated with that given CMakeList.txt cmake configuration file.

## Using CMake on the Command Line

If you have been using Visual Studio Code CMake extension.  This is great news since it removes some of the need to be able 
to run the build commands.  The problem is that this doesn't lend itself to building and running the tests within a CI/CD
environment like Jenkins or Github Workflow products.  Let us look at how you can execute the cmake and ctest commands on the
command line.

Note that every executed command will be executed from the top-level project directory.

```sh
    $ cmake --build <build_dir>
    $ cmake --build <build_dir> --target clean
```

The above command requires that you pass the build directory that contains all of the generated build files to build your project
with.  Usually the "&lt;build_dir&gt;" is the top-level project "build" directory.

```sh
    $ ctest --test-dir <build_dir>
    $ ctest --test-dir <build_dir_for_tests> -R "<test_regex>"
```

While the above is pretty simple it does offer the ability to selectively run one of more test.  While this is not the only
way one can run tests.  There are several IDEs that already contain CMake integrations like Visual Studio Code.

The "&lt;build_dir&gt;" is by default the top-level project *build* directory on my windows development.  I have not determined
if this is the case when building a C++ project using CMake on Linux or MacOS will also use the same directory by default.

The *"&lt;build_dir_for_tests&gt;"* can be used to run a subset of the tests that you've developed as part of your CMake project.
This schema can be useful when your project contains sub-directory builds for different aspects of your project.  For instance,
you might have a "books" sub-project that you want to run tests on.  You could then execute the following command:

```sh
    $ ctest --test-dir build/books
    $ ctest --test-dir -R "Titles.*"
```

The first command above will execute all tests within the books sub-project while the second command will execute all tests that
contain Titles in their test names.

## Conclusion

While the above information can get someone started.  The above is only a narrow view of what one can do using cmake to build your
C/C++ projects.  You can take a look at *CMake* documentation [here](https://cmake.org/cmake/help/latest/){:target="_blank"}.

{% comment %}
Local Variables:
backup-inhibited: t
End:
{% endcomment %}
