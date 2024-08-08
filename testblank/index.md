---
layout: default
title: "Happy Jekylling!"
---

## You're ready to go!

Start developing your Jekyll website.

External url {% exturl href="https://www.google.com" %}Google LLC{% endexturl %}.

{% highlight cpp %}
class Foo {
private:
    int m_value;
public:
    Foo(value) : m_value(value) {} /* ctor */
    ~Foo() {} // dtor
};
{% endhighlight %}

{% highlight java %}
class Foo {
    private value;
    Foo(value) {
        this.value = value; /* setting the private value with the passed value by using the this syntax */
    }
}
{% endhighlight %}

```
# We are using the integrated version of GoogleTest with our builds and this is only supported in CMake 3.10.0 or greater
cmake_minimum_required(VERSION 3.10.0)
project(tools VERSION 0.8.4
    DESCRIPTION "Data Structure and Algorithm Solutions"
    HOMEPAGE_URL "https://github.com/ccorsi/learning/tree/cpp_data_structs_and_algos"
    LANGUAGES CXX)

# This is required to be able to have cmake generate the required test build files
enable_testing()

# This is required to be able to have cmake generate the required package files
include(CPack)

# setup the minimum C++ requirements
set(CXX_STANDARD 17)
set(CXX_STANDARD_REQUIRED true)

# Set the default library build to static instead of shared
option(BUILD_SHARED_LIBS "Build using shared libraries" OFF)

include(FetchContent)

# To be able to use google test framework we need to fetch the source code that will be used to build
# and run this projects tests using google test framework.
FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG main # GIT_TAG release-1.12.1
)
```

## Continue

This section will contain some added writing to determine if the watch will properly updated the web site live.

