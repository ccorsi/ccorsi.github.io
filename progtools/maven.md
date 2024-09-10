---
title: Maven
subtitle: General Notes
sidebar: progtools-java
---


[Maven](https://maven.apache.org/){:target="_blank"} is a tool that simplifies the building, testing,
packaging and deploying of java projects.  It encapsulates that work within a fairly simple xml file
named pom.xml.  This file contains all of the information required to work with your project.  The
beauty is that you have the ability to pick and choose which third party packages you would like to
use within your project.  Maven will get those required packages and automatically apply them to
your build process.

I will give a overview of how to use Maven to build a fairly straight forward java project that only
requires some packages to needed to build, test and run.

## Installation

We shall thus start with downloading the latest version of Maven which is located at the following
[Maven download](https://maven.apache.org/download.cgi){:target="_blank"}.  After expanding the
operating system archive file.  You need to insure that the bin directory of your maven top-level
directory is part of your path.  You will also need a java version installed on your system.  Maven
will use the one that is part of your path or it will use the one that is defined by the JAVA_HOME
environment variable.  You can then check if maven was properly configured by running the following
command:

```shell
$ mvn --version
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: C:\tools\maven\3.6.3
Java version: 20.0.1, vendor: Oracle Corporation, runtime: C:\tools\java\jdk\openjdk\20
Default locale: en_US, platform encoding: UTF-8
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"
```

Now that we have maven properly installed on your system we can then look at creating a simple maven
project from the command line.

## A Simple Project

Maven offers the concept of plugins that can be used within a maven project.  Plugins can be used
for different uses and one of them is to create new maven projects.  These type of plugins are called
archetypes which can be used to create a maven project using the following command:

```shell
$ mvn archetype:generate
```

While the above can be used to create a new maven project from a list of archetypes.  This is great
but the issue is that there are thousands of possible archetypes to choose from.  We will then show
you how you can create a simple maven project using the following command:

```shell
$ mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------< org.apache.maven:standalone-pom >-------------------
[INFO] Building Maven Stub Project (No POM) 1
[INFO] --------------------------------[ pom ]---------------------------------
[INFO]
[INFO] >>> maven-archetype-plugin:3.2.1:generate (default-cli) > generate-sources @ standalone-pom >>>
[INFO]
[INFO] <<< maven-archetype-plugin:3.2.1:generate (default-cli) < generate-sources @ standalone-pom <<<
[INFO]
[INFO]
[INFO] --- maven-archetype-plugin:3.2.1:generate (default-cli) @ standalone-pom ---
[INFO] Generating project in Interactive mode
[INFO] Archetype [org.apache.maven.archetypes:maven-archetype-quickstart:1.4] found in catalog remote
Define value for property 'groupId': org.example
Define value for property 'artifactId': simple-example
Define value for property 'version' 1.0-SNAPSHOT: :
Define value for property 'package' org.example: :
Confirm properties configuration:
groupId: org.example
artifactId: simple-example
version: 1.0-SNAPSHOT
package: org.example
 Y: :
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating project from Archetype: maven-archetype-quickstart:1.4
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: groupId, Value: org.example
[INFO] Parameter: artifactId, Value: simple-example
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] Parameter: package, Value: org.example
[INFO] Parameter: packageInPathFormat, Value: org/example
[INFO] Parameter: package, Value: org.example
[INFO] Parameter: groupId, Value: org.example
[INFO] Parameter: artifactId, Value: simple-example
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] Project created from Archetype in dir: C:\projects\java\maven\simple-example
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  25.154 s
[INFO] Finished at: 2024-03-12T18:36:32-04:00
[INFO] ------------------------------------------------------------------------
```

Upon the completion of the above command.  It will generate the following files within the simple-example
directory.

```
pom.xml  src/

simple-example/src:
main/  test/

simple-example/src/main:
java/

simple-example/src/main/java:
org/

simple-example/src/main/java/org:
example/

simple-example/src/main/java/org/example:
App.java

simple-example/src/test:
java/

simple-example/src/test/java:
org/

simple-example/src/test/java/org:
example/

simple-example/src/test/java/org/example:
AppTest.java
```

While the pom.xml file looks like the following.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>org.example</groupId>
  <artifactId>simple-example</artifactId>
  <version>1.0-SNAPSHOT</version>

  <name>simple-example</name>
  <!-- FIXME change it to the project's website -->
  <url>http://www.example.com</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
      <plugins>
        <!-- clean lifecycle, see https://maven.apache.org/ref/current/maven-core/lifecycles.html#clean_Lifecycle -->
        <plugin>
          <artifactId>maven-clean-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <!-- default lifecycle, jar packaging: see https://maven.apache.org/ref/current/maven-core/default-bindings.html#Plugin_bindings_for_jar_packaging -->
        <plugin>
          <artifactId>maven-resources-plugin</artifactId>
          <version>3.0.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.8.0</version>
        </plugin>
        <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>2.22.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-jar-plugin</artifactId>
          <version>3.0.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-install-plugin</artifactId>
          <version>2.5.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-deploy-plugin</artifactId>
          <version>2.8.2</version>
        </plugin>
        <!-- site lifecycle, see https://maven.apache.org/ref/current/maven-core/lifecycles.html#site_Lifecycle -->
        <plugin>
          <artifactId>maven-site-plugin</artifactId>
          <version>3.7.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-project-info-reports-plugin</artifactId>
          <version>3.0.0</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>
</project>
```

While the above pom file contains what is required to build and test this simple example java application.
It currently uses the JUnit 4 framework instead of the latest JUnit 5 framework.  We will look at how to
update this to use JUnit 5 later on.  The other information that needs to be mentioned is that the pom needs
to be updated to be able to build and test this project.  The following properties needed to be updated.

- maven.compiler.source
- maven.compiler.target

They needed to be set to java version 8 or greater instead of the default version of 1.7 to be able to build
and test this project.  This is required because java 1.7 is not supported any longer with the newer version
of the Java JDK.

You can then build, test and package the above maven project using the following commands:

```shell
$ mvn compile
$ mvn test
$ mvn package
```

The compile target will build the source files within the src/main sub-directory.  While the
test target will build and run the tests within the src/test sub-directory.  While the package
target will generate a jar file that contains the built files from the src/main sub-directory.

The above information is a good starting point when using Maven but alas there are many more
options that one needs to know about Maven and this will be discussed further in this page.

Let us now look at how we define and use third party dependencies within a Maven project next.

## Dependencies

The following sections will describe different ways of adding dependencies and how to include these dependencies
in your packaged archive files used to run your project.

### Adding Dependencies

We shall start this with describing how one goes about adding dependencies to your maven project.  Maven intends
to make the handling of third party packages as simple as possible.  This includes the need to retrieve those
packages and adding them to your build process.  Let us then look at how one goes about adding a dependency to
your maven project.

Let us start by adding the JUnit package to your maven project.  Maven created a repository that includes an assortment
of java packages that one can use called the Maven Central Repository.  This repository can be searched by going
to the [MVN Repository](https://mvnrepository.com/repos/central){:target="_blank"} or to the
[Sonatype Maven Central Repository](https://central.sonatype.com/){:target="_blank"} websites.  Both of these websites
provide search capabilities to allow one to find the required java packages needed for your project.  We can then
search for the JUnit package by entering "junit" in the search input box.  The resulting search will offer you
several java packages that you can choose from but we will then pick the junit-jupiter-engine package.  These
websites make is easy for one to include any of these packages within your maven project by supplying an example
dependency tag.  For instance,

```xml
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-engine</artifactId>
    <version>5.10.2</version>
</dependency>
```

You can then copy this and include it in your maven project pom.xml file.  This tag needs to be added to the
dependencies tag to be correctly processed by the maven build process.


### Create an Executable Jar

We are now going to look how you can use maven to generate an executable jar file.  Recall that an executable
jar file contains a manifest with the Main-Class attroibute set to the fully qualified class name.  Let us assume
that we have a main class named, org.example.Main, that is part of a current maven project.  We are then going
to create an executable jar file.  The first thing that we need to do is include the maven jar plugin.  The
pom.xml file will need to include the following plugin within the build->plugins tag as follows.

```xml
<project>
    ...
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.3.0</version>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>org.example.Main</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
            ...
        </plugins>
    </build>
    ...
</project>
```

When the _mvn package_ command is executed an executable jar file will be create and located with the target
sub-directory.  The main class can then be executed using the -jar option of the java command as follows.

```sh
$ java -jar <jar-file-name>
```

The above java command will look for the manifest in the passed jar file.  It will then look for the Main-Class
attribute within the jar manifest file.  If it finds, one it will then run the main static method from that
class.  If the main class expects command line arguements then all you need to do is to append the required
command line arguements to the above command.

While the above information is pretty clear there are other configurations that one can set using the
maven-jar-plugin that can be found at the
[Maven Jar Plugin](https://maven.apache.org/plugins/maven-jar-plugin/index.html){:target="_blank"} web page.
In the meantime, we will look at some of the more promising configurations that are useful within maven java
projects.

### Add Library Dependencies to the Executable Jar Archive

In my humble opinion, maven strength is its ability to implicitly access and include third party libraries
as part of a maven project.  It simplifies the need to setup the project build and testing process.  The
use of the maven-jar-plugin also simplifies the need to create an executable jar archive that accesses
these third party libraries.  While there are different configurations options that one can use to set the
jar file classpath.  I will assume that we have all the maven project third-party libraries located in the
lib sub-directory where the jar file is located.  Let us look at a simple pom file that contains a third-party
library requirement for a given maven project.

```xml
<project>
  ...
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-jar-plugin</artifactId>
        ...
        <configuration>
          <archive>
            <manifest>
              <addClasspath>true</addClasspath>
              <mainClass>fully.qualified.MainClass</mainClass>
              <classpathPrefix>lib/</classpathPrefix>
            </manifest>
          </archive>
        </configuration>
        ...
      </plugin>
    </plugins>
  </build>
  ...
  <dependencies>
    <dependency>
      <groupId>commons-lang</groupId>
      <artifactId>commons-lang</artifactId>
      <version>2.1</version>
    </dependency>
    <dependency>
      <groupId>org.codehaus.plexus</groupId>
      <artifactId>plexus-utils</artifactId>
      <version>1.1</version>
    </dependency>
  </dependencies>
  ...
</project>
```

The above pom update will generate the maven project jar file with the manifest Class-Path attribute set to

```
Class-Path: lib/plexus-utils-1.1.jar lib/commons-lang-2.1.jar
```

Thus when the executable jar file is executed where the these jar files are located in the lib sub-directory
where the executable jar file is located.  The main class will be executed and the required dependent
third-party jar archives will be accessible to the java application.

While the above configures that jar archive Class-Path attribute.  It doesn't actually place the required
dependencies with the lib sub-directory.  This will require another plugin to perform that task which will be
described next.

### Copy Dependencies to a Directory

While the last example updates a jar file manifest file to define the required classpath of the executable
jar file.  It doesn't provide the access to the third-party jar files.  The maven-dependency-plugin is used
to copy the required third-party libraries to a destination directory.  Let us take the prior section lib
sub-directory destination.  Then the project pom file should contain the following plugin definition.

```xml
<project>
  [...]
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-dependency-plugin</artifactId>
        <version>3.6.1</version>
        <executions>
          <execution>
            <id>copy-dependencies</id>
            <phase>package</phase>
            <goals>
              <goal>copy-dependencies</goal>
            </goals>
            <configuration>
              <outputDirectory>${project.build.directory}/lib</outputDirectory>
              <overWriteReleases>false</overWriteReleases>
              <overWriteSnapshots>false</overWriteSnapshots>
              <overWriteIfNewer>true</overWriteIfNewer>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
  [...]
  <dependencies>
    <dependency>
      <groupId>commons-lang</groupId>
      <artifactId>commons-lang</artifactId>
      <version>2.1</version>
    </dependency>
    <dependency>
      <groupId>org.codehaus.plexus</groupId>
      <artifactId>plexus-utils</artifactId>
      <version>1.1</version>
    </dependency>
  </dependencies>
  [...]
</project>
```

The jar files plexus-utils-1.1.jar and commons-lang-2.1.jar will be copied to the lib sub-directory within
the target sub-directory.  You can then package these jar files and the executable jar file together and
the executable jar file can be executed with the required third-party library files.

More information about the maven-dependency-plugin can be found at the
[Maven Dependency Plugin](https://maven.apache.org/plugins/maven-dependency-plugin/index.html){:target="_blank"}
website.
