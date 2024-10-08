---
title: GoogleTest
subtitle: Useful Pointers
sidebar: progtools-cpp
---

When I intially started to use CMake I ended up using the CMake testing feature that comes with the CMake product.  This was a useful feature but
it isn't as feature rich as GoogleTests.  I then started to write Google Tests for my different CMake projects which used features which were not
part of CMake default testing feature.  Here are some of the features that I have come to use. They are here as reminders for future use
of GoogleTests framework.

## Tests

There are several types of tests that one would be inclined to use.  I will only mention the ones that I have used myself.  For more information
on which other tests one can create, I would recommend you take a look at the official
[GoogleTest](http://google.github.io/googletest/){:target="_blank"} website.

GoogleTest provides several options when creating a test.  They've created several macros that simplify the development of the different tests.
Let us start by looking at the simplest version of such a test.  We can define a simple test using the
[TEST](http://google.github.io/googletest/reference/testing.html#TEST){:target="_blank"} macro:

```cpp
TEST(TestSuiteName, TestName) {
  ...statements...
}
```

The above is a very simple option one can use to create a simple test that doesn't require much work except understanding how one goes about
checking that a result is valid or not using one of the [Assertions](http://google.github.io/googletest/reference/assertions.html){:target="_blank"}
macros.  These provide the ability to track which test were successful or not.  While the above test is great for creating tests that contain all
the required configuration within the test.  They don't provide the ability to reuse the same test for different inputs and expected outputs.  This
will require a more flexible test.  This is where a parameterized test would be better.

While the above test implementation is enough to create a test.  It does lack some flexibility to reuse the same test for different inputs
and outputs.  I was then looking for such a test that can be created using GoogleTest.  I then found the
[TEST_P](http://google.github.io/googletest/reference/testing.html#TEST_P){:target="_blank"} macro:

```cpp
TEST_P(TestFixture, TestName) {
  ...statements...
}
```

The *TEST_P* macro provides several different features that can be useful for reusing the same test definition for multiple combinations of inputs
and/or outputs.

There are some differences between the definition of the *TEST* and *TEST_P* macros.  The main difference is that the *TEST_P* requires you to pass a test
fixture class for it to be able to define these types of tests.  The parameterized test fixture class requires that it implements the
<code>testing::WithParamInterface&lt;T&gt;</code> template for type T which is derived from the <code>testing::Test</code> class. The type *T* for the
*WithParamInterface* is the unique data that the test will use for the defined parameter test.  This provide the ability to reuse a single test
definition which uses different input/output conditions.  For instance,

```cpp
// Data class expected for the DataFixture class
class Data {
   ...
public:
   Data() = default;
   Data(...) {}
};

// Test Fixture class implementations for parameterized tests
class DataFixture : public testing::WithParamInterface<Data> {
};
```

While the above *TEST_P* definition defines a parameterized test, it doesn't provide the ability to pass parameters to the given parameterized test.
This is done using the [INSTANTIATE_TEST_SUITE_P](http://google.github.io/googletest/reference/testing.html#INSTANTIATE_TEST_SUITE_P){:target="_blank"}
macro:

```cpp
INSTANTIATE_TEST_SUITE(InstantiationName, TestSuiteName, param_generator [, name_generator ]);
```

The *InstantiationName* is just a unique name prefix associated with the above parameterized test.  The *TestSuiteName* is what was defined as the
*TestSuiteName* for the defined *TEST_P* test.  This is really just the name of the *TestFixture* class that was used by the *TEST_P* macro.  While
the *param_generator* is used to pass the parameters for each test run.  There are several options that one can use to pass parameters to the
defined parameter test associated with this instance.  Let us look at the two that I have used before.

There is the <code>::testing::Values(v1, v2, ..., vN)</code> where you pass it *N* values that will be passed to the parameterized test.  The *N* values
will then generate *N* different test runs for the defined parameterized test.  The passed values are the expected parameter type *T* that the
parameterized test expects to be passed.  For example:

```cpp
// Parameter Test Parameter Type
class Data {
  ...
public:
  Data() = default;
  Data(...) {}
};

// Parameter Test Fixture
class DataFixture :
    public testing::TestWithParam<Data> {
    ...
};

// Parameterized Test Definition
TEST_P(DataFixture, DataTests) {
   Data data = GetParam(); // get a reference to the parameter values associated with this test

   ...statements...
}

// Parameter Test Parameters
INSTANTIATE_TEST_SUITE_P(DataTests, DataFixture, testing::Values(Data(...), Data(...), ...));

```

The Test Fixture associated to the parameterized test expects a *Data* class to be passed.  Thus the parameter list is supposed to be of that type.
This provides one the ability to pass as many combinations of input/outputs that one would like to test.  The parameterized test definition can
then access this passed Data instance using the <code>GetParam()</code> function.  This will return an instance of the passed type.  The
test can then use this information to test the required functionality.  One can be pretty creative with this technique by creating a parameter
class to include an infinite amount of input/output information that can be used by the parameterized test definition.

While the use of the <code>testing::Values(...)</code> parameter generator is very valuable when creating and using the *TEST_P* macro.  It does
have a drawback which is when adding new input/output combinations.  One has to compile the code everytime new input/output combinations are
added.  This can be make the turnaround of the test take longer when initially creating and using the parameter test.  There is another way around
this issue.  This can be accomplished by using the <code>testing::ValuesIn</code> feature.

While the <code>testing::Values</code> example above is useful it will affect the turnaround of the tests when make adding new test combinations.
There is a technique that I have devised that will make this process easier and faster.  The issue is that test definitions are usually static in
the sense that when a test definition is created a test will not be changed unless there are changes to the testing features themselves.  Thus
removing the need to compile the test is something that would be useful.   We can then use a combination of the <code>testing::ValuesIn</code>
class and a loading class that load instances of the parameter class.  Here is an example:

```cpp
// Paramter Test Parameter Type
class Data {
  ...
public:
  Data() = default;
  Data(...) {}

  friend std::istream& operator>>(std::istream&, Data&);
};

std::stream& operator>>(std::istream & in, Data & data) {
   ...statements...

   return in;
}

// Parameter Test Fixture
class DataFixture :
   public testing::TestWithParam<Data> {
   ...
};
// Parameterized Test Definition
TEST_P(DataFixture, DataTests) {
   Data data = GetParam(); // get a reference to the parameter values associated with this test

   ...statements...
}

// Parameter Test Parameters
INSTANTIATE_TEST_SUITE_P(DataTests, DataFixture,
  testing::ValuesIn(Loader<Data>()(find_path("data.txt")))
);
```

The above code uses the *ValuesIn* feature that is passed a container generated by the *Loader* class.  The Loader class expects the
path of a file that contains the data to be loaded into the container which is passed to the *ValuesIn* call.  The Loader class
will create an instance of the *Data* type and use the passed *std::istream* instance returned by the *find_path* method to load the
data in the Data instance.  This will make it easier to add new test combinations for the defined parameter test without
requiring the need to compile the test everytime a new test combinations was added.   If one is interested in how the helper
tools are implemented.  Here is a link to the
[Loader&lt;T&gt;](https://github.com/ccorsi/learning/blob/cpp_data_structs_and_algos/utils/includes/loader.h){:target="_blank"}
and [find_path()](https://github.com/ccorsi/learning/blob/cpp_data_structs_and_algos/utils/paths.cpp){:target="_blank"} sources.

While the above example explains show the data is loaded by the loader.  It doesn't explain how the data is loaded by the Data class.
This is done by defining the *operator&gt;&gt;* for the Data class.  Let us look at one example of such a definition.

```cpp
// Paramter Test Parameter Type
class Data {
  int m_input;
  int m_expected;
public:
  Data() = default;
  Data(...) {}

  friend std::istream& operator>>(std::istream&, Data&);
};

std::stream& operator>>(std::istream & in, Data & data) {
  in >> data.m_input;
  std::string line;
  std::getline(in, line); // read end of line

  in >> data.m_expected;
  std::getline(in, line); // read end of line

  return in;
}
```

Let us now disect the above implementation of the *operator&gt;&gt;* for the Data class.  The first thing to note is that we use the passed
*std::istream* to load the values of the *m_input* and *m_expected* into the Data class.  While in this example we use of the *std::getline*
method to insure that we move to the next line in the istream.  In this case, we are assuming that the file will contain the following format.

```text
[input integer]
[expected integer]
[input integer]
[expected integer]
...
```

The above format is what the *operator&gt;&gt;* is expected to process.  The Loader class will then check if there is more data that
needs to be processed after each instantiation and loading of a Data class instance.  While this can produce one of more instance
of the Data class.  It can then be used to create several test combinations without needing to compile the test when adding
new test combinations.  While the above simple example is not unique to the type of data that the Data class needs.  We will
now look at several different types of data that the Data class might want to load.  Let us look at one that requires an
array of data.

```cpp
// Paramter Test Parameter Type
class Data {
  std::vector<int> m_input;
  std::vector<int> m_expected;
public:
  Data() = default;
  Data(...) {}

  friend std::istream& operator>>(std::istream&, Data&);
};

std::stream& operator>>(std::istream & in, Data & data) {
  ::loaders::vectors::vectorLoader<int> inputLoader(data.m_input, '[', ']');
  in >> inputLoader;

  ::loaders::vectors::vectorLoader<
    int,
    std::vector<int>,
    char,
    ::checkers::is_space_or<','>
  > expectedLoader(data.m_expected, '{', '}');
  in >> expectedLoader;

  return in;
}
```

The above implementation of the *operator&gt;&gt;* for the Data class uses the *vectorLoader* template class to load the data into the
Data instances.  This implementations uses two different vectorLoader template instantiation, one for the input array and the
other for the expected array.  They are both loading integer type data into a vector instance of the Data instance.  Before
explaining how the vectorLoader template class works.  Let start by describing the file format that the *operator&gt;&gt;* expects
to use to load the data from.

```text
[1 2 3 4]
{1, 2, 3, 4, 5}
[1 2 3 4]
{1, 2, 3, 4, 5}
...
```

The first *inputLoader* definition expect the entries to be formatted such that the input is surrounded by the '[' and ']'
characters where each integer are separated by one or more space like characters.  This is what is defined by the
<a href="https://en.cppreference.com/w/cpp/string/byte/isspace" target="_blank">std::isspace</a> method call.  This implies
that one can use the following valid arrays:

```text
[1  2  3  4 5 6 7  7 8 9 10]
[1 2 3 4 5]
[    1 2 3 4 5     ]
```

All of the above arrays are valid input for the *m_input* field.

As noted above the *m_expected* field will expect a differently formatted array of integers.  The expected array will expect
the integers to be surrounded by '{' and '}' characters and is seperated by space characters as above but they can also be
seperated by ',' characters as follows:

```text
[1, 2, 3, 4, 5]
[1  ,    2,  3   ,  4, 5]
[   1, 2, 3, 4, 5    ]
```

All of the above combinations are valid for the *m_expected* field.

As a final note, the *vectorLoader* template class will throw the standard
<a href="https://en.cppreference.com/w/cpp/error/runtime_error" target="_blank">std::runtime_error</a> exception if it
encounters an invalid input format.  This will allow the implementor to be able to pinpoint why the Data class was not
able to load the data.

While the above example shows one how to load an array of integer data.  The vectorLoader template can also load other types
of data like double, float, long, char and string types.  It can load any of the standard data types.  The key is that those
types have to define an associated *operator&gt;&gt;* method.

Another aspect of the vectorLoader template class is that you can define what type of container to use to load the data into
but it does have a caveat.  The caveat is that the container needs to implement the <code>push_back</code> method.  This is
the one requirement that cannot be changed with the current implementation of the *vectorLoader* template class.

The *vectorLoader* template class also uses a *IsSpace* typename that implements the <code>operator()(char)</code> operator.
There are several version of these operators in the *valhalla::utils::checkers* namespace.  One need not have to create their own
since the ones available in the *valhalla::utils::checkers* namespace should suffice.  If one expects other type of separators that
are not part of the *isspace* method.  The use of the <code>is_space_or</code> template instance can be used instead. It expects
one or more characters to look for as part of its definition.  For instance, the above definition states that it expected to process
',' as space like characters. If one expects "," and "'" characters as space like characters then the <code>is_space_or</code>
can be defined as <code>is_space_or&lt;',', '\''&gt;</code>.

While the above shows how one can use the *vectorLoader* template class there are other template classes that one can use.  Here
is a link to these different classes and their source code.

- <a href="https://github.com/ccorsi/learning/blob/cpp_data_structs_and_algos/utils/includes/vector_loader.h" target="_blank">vector_loader.h</a>
- <a href="https://github.com/ccorsi/learning/blob/cpp_data_structs_and_algos/utils/includes/set_loader.h" target="_blank">set_loader.h</a>
- <a href="https://github.com/ccorsi/learning/blob/cpp_data_structs_and_algos/utils/includes/pair_loader.h" target="_blank">pair_loader.h</a>
- <a href="https://github.com/ccorsi/learning/blob/cpp_data_structs_and_algos/utils/includes/matrix_loader.h" target="_blank">matrix_loader.h</a>
- <a href="https://github.com/ccorsi/learning/blob/cpp_data_structs_and_algos/utils/includes/checkers.h" target="_blank">checkers.h</a>

The above templates should be more than adequate to load any combinations of data that one might require.

While the above container type template loader classes have been useful.  They haven't always made loading of data classes easy.
The above was my initial attempt creating these type of template classes but these have evolved since this initial attempt.
Thus, more discussion on these types of template type loader classes will be continued in another section. You can then read
more about this in the [Template Loader Classes](/projects/loaders/) page.

## Command line options

When Google Tests is executed, it will generate a default test report that is printed to standard out.  There is going to be cases in which
the generated test results should be formatted such that we are able to produce a test report.  This is the case when executing GoogleTest
within a Jenkins and GitHub Workflow environment.  GoogleTests provides the ability to generate xml or json test reports.  There are two
ways that this can be done.  You can set the **GTEST_OUTPUT** environment variable or use the **--gtest_output** command line parameter
when executing the tests.  Here is an example of using the environment variable and command line parameter.

```shell
$ export GTEST_OUTPUT=xml:xunit_report.xml
$ ./tests_progrem --gtest_output=xml:xunit_report.xml
```

The above settings will generate the *xunit_report.xml* file in the directory that the tests_program were executed in.  If you want to generate
a json report then you can use the following.

```shell
$ export GTEST_OUTPUT=json:xunit_report.json
$ ./tests_progrem --gtest_output=json:xunit_report.json
```

While the above will work fine, it does contain an issue in which the generated xunit_report.xml file will be overrided if there are
more than one tests within the same sub-directory.  In this case, you will need to use a different setting of the GTEST_OUTPUT environment
variable.  Instead of defining a file name, we then use a directory name.  This can be set as:

```shell
$ export GTEST_OUTPUT=xml:testResults/
```

Note that at the end of the directory name, we add the '/' character.  This tells google tests that this is a directory and that the resulting
tests information is written within that directory.  Google tests will create the directory if none exists and it will then create the
test result file using the executable test name with the .xml extension added.  This will then guarantee that the test result file will not
be overriden.

## Conclusion

While this page contains several pointers on how to use GoogleTest. It surely doesn't completely describe all of the different features
that are part of the GoogleTest framework.  As I get to use more of those features.  This web page will be updated with information about them
in hopes that it can be useful to others who use GoogleTests.

Again, thanks for tagging along and I do hope that some aspect of the above information was useful.
