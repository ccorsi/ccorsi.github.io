---
title: JUnit
subtitle: Testing Framework
sidebar: progtools-java
---

This section will describe how to use the JUnit framework to create and run tests against your developed classes.  JUnit was
initially created by Erich Gamma and Kent Beck.  JUnit has evolved throughout the years and its latest incarnation is JUnit 5
which we will be describing in this section.

## Minimial Test

While JUnit 5 contains a really good [User Guide](https://junit.org/junit5/docs/current/user-guide/){:target="_blank"}.  We will
only give enough information here to get you started with this framework.  Let us then look at how we can create a test the
following Point class.

```java
package org.example;

public class Point {

    private int x, y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public int getX() { return x; }
    public int getY() { return y; }

    public void setX(int x) { this.x = x; }
    public void setY(int y) { this.y = y; }
}
```

The first thing that one should consider when creating tests is what is a good pattern to follow?  You should create the test
class using the same package as the class that you are testing.  Thus a test class for the Point can be defined as.

```java
package org.example;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;

public class PointTest {

    @BeforeAll
    static void beforeAll() {
        ...
    }

    @AfterAll
    static void afterAll() {
        ...
    }

    @BeforeEach
    void beforeEach() {
        ...
    }

    @AfterEach
    void afterEach() {
        ...
    }

    @Test
    void testOne() {
        Point point = new Point(1,2);

        Asserions.assertEqual(point.getX(), 1);
        Asserions.assertEqual(point.getY(), 1);
    }

    @Test
    void testTwo() {
        Assertions.fail("This is a failed test");
        ...
    }

    // Helper methods.
    private Point create(int x, int y) {
        return new Point(x,y);
    }

    ...

}
```

The above test should offer enough to be able to get started when writing tests using the JUnit 5 framework.  The
JUnit 5 framework uses the Assertions class methods to determine if the given tests are successful or not.  These
methods will generate an exception if the given conditional test is incorrect.  The generated exception will contain
information about the discrepency of the test by describing what is expected and what was the actually produced.

We now explain the anatomy of the above test.  The references with the preceeding @ sign are called annotations
and this is used by the JUnit framework to determine how those methods should be called.   The ones that contain
the __BeforeAll__ and __AfterAll__ annotations will be executed before and after __all__ test methods that have
been defined.  While the ones that contain the __BeforeEach__ and __AfterEach__ annotations will be executed before
and after __each__ defined test.  While the ones with the __Test__ annotations are actually the tests that will be
executed.  Finally, the above test class contains methods that are not called by the JUnit framework but that are
used by the test for whatever needs it is required.   This just shows that one doesn't need to only define methods
that are annotated with the JUnit framework annotations.

## Conditional Test Annotations

This section will expand on the features that are part of the JUnit test framework.  We will take a look at how
one can go about running tests given different conditional requirements that you can easily implement.  Let us
then look at how we can use the
[EnableIf](https://junit.org/junit5/docs/current/api/org.junit.jupiter.api/org/junit/jupiter/api/condition/EnabledIf.html){:target="_blank"}
annotation.   Let us then add an EnabledIf check to the PointTest

```java
package org.example;

import org.junit.jupiter.api.Test;
...
import org.junit.jupiter.api.condition.EnableIf;

public class PointTest {

    public boolean condition() {
        ...
    }

    @EnabledIf("condition")
    @Test
    public void test() {
        ...
    }
}
```

The above use of the **EnabledIf** conditional test annotation will determine if the given ___test___ method will
be executed or not depending on the ___condition___ method return statement.  Note that the ___condition___ method
will return a **boolean** value.  This is a requirement for the use of the **EnabledIf** conditional test
annotation.  This also the case with the **DisabledIf** conditional test annotation.  This above was a simple
implementation of one of the different conditional test annotations that the JUnit5 test framework contains.
There are other conditional test annotations that are avaliable at
[Conditional Test Annotations](https://junit.org/junit5/docs/current/api/org.junit.jupiter.api/org/junit/jupiter/api/condition/package-summary.html){:target="_blank"}.

## Conclusion

While the JUnit __Test__, __BeforeEach__, __AfterEach__, __BeforeAll__ and __AfterAll__ annotations and the
__Assertions__ class should suffice to get start with the JUnit 5 framework.  There are other annotations and
assertions that one can use at the following
[JUnit Javadoc](https://junit.org/junit5/docs/current/api/){:target="_blank"} link or one can look at the
[JUnit User Guide](https://junit.org/junit5/docs/current/user-guide/){:target="_blank"}.
