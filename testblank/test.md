---
layout: page
title: This is a simple page test
---

# Introduction

Let us see what this generates

```java

class Foo {
    private int value

    public Foo(int value) {
        this.value = value; // This guarantees that we assign the correct value to the correct field
    }
}

```

```cpp

class Foo {
private:
    int m_value;

public:
    Foo(int value) : m_value(value) {
        // You don't need to assign m_value here
    }
};

```

This is the last line of the page!!!!