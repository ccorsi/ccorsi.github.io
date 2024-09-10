---
title: Java Tools
sidebar: progtools-java
---

The following page will contain information about the Java Programming Language ecosystem.  We will look
at different topics in an adhoc order.  Some of the information will be cross referenced but it is hoped
that the information can be of use to others.

## Java

While the Java Programming Language is a general purpose language having some elementary knowledge is a good start.
Let start with a simple java class and explain what each section means.  The following Main class will be created
in the Main.java within the src/org/example directory.

```java
package org.example;

import static java.lang.System.out;

import java.util.Arrays;

public class Main {

    public static void main(String[] args) {
        int [] values = new int[100];
        Arrays.fill(values, 1);
        out.println("Hello, world!");
    }
}
```

The above Main class can be compiled using the following command:

```sh
$ javac -d classes src/org/example/Main.java
```

The class can then be run using the following command:

```sh
$ java -cp classes org.example.Main
Hello, world!
```

As can be seen above the created class just prints "Hello, world!" and exits.  We are now going to explain how the
Main class was defined and used.  One can also use the __CLASSPATH__ environment variable to execute the Main class.

```sh
$ export CLASSPATH=classes
$ java org.example.Main
```

Note that the above assumes that the java command is executed within the directory that contains the classes sub-directory.
This is only a requirement if you are using relative directories in the classpath.  If you use absolute path in the classpath
then you can execute the java command from any directory.  The example above also only includes a single directory.  The
java classpath can also include multiple directories and/or archives that contain the required classes.  These archives
are usually jar files that are added to the classpath.  For instance, assume we have a jar file named, bar.jar then
the classpath is defined like

```sh
$ java -cp classes:bar.jar org.example.Main
```

or

```sh
$ export CLASSPATH=classes:bar.jar
$ java org.example.Main
```

Again, replacing the relative path names with their absolute path names allow you to execute the java command from anywhere.

Let us start with the __package__ statement above is used to confine classes within a given silo.  This silo allows
one to create classes with the same name and it insures that they won't class with each other.  The package name also
has another function that is useful when creating and using Java classes.  This in relation to compiling and executing
the compiled classes.  The __javac__ compiler command executed with the -d &lt;top-level-directory&gt; option will
create the org/example directory in the &lt;top-level-directory&gt; directory.  The compiler will generate a Main.class
file in the org/example directory.  This is the file that will be used when executing the __java__ command above.

Let us explain what is the significants of the other syntax in the java class file.  The first thing to notice is the
__import__ key word that is being used in the Main class.  There is the __import static java.lang.System.out;__ that
is used by the compiler that all references to the __out__ static field is a reference from the __java.lang.System__ class.
While the __import java.util.Arrays;__ import tells the java compiler that all reference to __Arrays__ is really a reference
to __java.util.Arrays__.  This basically makes it such that the code is less cluttered with fully qualified class names.

Let now turn to defining the class itself such that the java command can execute the requested java class.  The first
requirement when creating a java class is that the name of the class should coincide with the name of the .java file name.
Thus the creation of the Main.java file is required by the java compiler.

The next requirement is the definition of the Main class.  For this, the Main needs to be made accessible to the java run time.
This then requires that the class be made __public__.  The java command will look for the requested class which in our case
the __org.example.Main__ class.  The java runtime will then look for a standard entry point.  In this case, it will
look for the static public void main method that expects a String array parameter,
__static public void main(String[] args)__ method.  This static method is only required for an entry class.  This method
is not required by non-entry point classes.

Finally, let us look at the anatomy of a java class.  Here is a simple java class that will define the different
methods and fields of a simple class below.

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

The above contains two fields, (x and y), a single constructor, and 4 instance functions.  When defining your class fields
you need to define their access.  The fields can then contain the following access.

| Type | Description |
| :--- | :---: |
| __private__ | These fields can only be accessed by the current class |
| __protected__ | These fields can only be accessed by the current class or any defined sub-class |
| __public__ | These fields can be accessed by anyone |
| &lt;blank&gt; | These fields can be accessed by class with the same package name |

The above definition is fairly obvious except for the __blank__ access.  This is something that I have personally
never needed use of but that is part of the java language specification.

Note that the above definitions is also the case for methods defined in the class.

One last note that java generates documentation that is package and class specific.  This documentation is located at
[Java JDK 21 Documentation](https://docs.oracle.com/en/java/javase/21/docs/api/index.html){:target="_blank"}.
