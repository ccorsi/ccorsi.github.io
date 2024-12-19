---
title: Action Default Value
subtitle: Python Standard argparse Package
author: Claudio Corsi
date: 2024-12-17 19:28:07 -0500
tags: [ Python, argparse, argparse.Action ]
categories: [ Python ]
debug: true
published: true
---

This article discusses the use of the argparse Action class that can be used to create
user specific command line actions.  We then take the liberty that one already understands
how to use the argparse Python package.  If that is not the case then you can take a look
at the <a href="https://docs.python.org/3/library/argparse.html" target="_blank">argparse</a>
package documentation.

The argparse Python package is used to parse command line arguments for Python scripts.
It allows one to be able to easily implement command line arguments processing using its
default implementations. There are cases in which those default implementations will not
provide the required features. These features can then be implemented using the argparse
Action classs. One sub-classes the Action class to implement the required feature. The
user-defined Action class can then be used in the same way as the default Action
implementations. This is the situation that I found myself in recently. I wanted to
implement an Action class that checked if a given directory exists for a given command
line argument.

Let us look at that initial implementation of the DirectoryAction that I was going to use
as part of one or more of my command line argument definitions.

```python
import argparse

class DirectoryAction(argparse.Action):
    def __init__(self, option_strings, dest, nargs='?', **kwargs):
        if nargs != '?':
            raise ValueError(f"nargs {nargs} is not allowed")
        super(DirectoryAction, self).__init__(option_strings, dest, nargs, kwargs)
 
    def __call__(self, parser, namespace, values, option_string=None):
        if not os.path.isdir(values):
            raise ValueError('{} has to be a directory'.format(values))
        setattr(namespace, self.dest, values)
```

The initial implementation for this DirectoryAction action class worked as expected. The next
step was to add a default value associated with that Action. The use of the add\_argument
method uses the *default* parameter to set the default value when the command line argument
is not used when executing the script. Doing this should then lead to the default value being
used if the command line argument wasn't passed. The initial run of the script without the
command line argument failed to use the default value. This lead me to look at the
documentation of the argparse Action class. While the documentation does discuss the use
of the default option. It didn't explain what was needed such that the passed default value
to the add\_argument call will be used by the user-defined Action implementation.

The above lead me to stepping through the source code of the add\_argument call to determine
why the passed default value to the add\_argument method was not being applied whenever the
command line argument was not passed. Upon looking through the code, I noticed that it
checks if the *default attribute* existed for the user-defined Action class. If it existed
then this default value was used. It was then not using the default value passed to the
add\_argument method call. The default argument value that was passed to the add\_argument
method call was passed on to the initialization of the user-defined Action during the
add\_argument method call. Thus, updating my user-defined Action class to store the passed
default value to its own *default attribute* resolved the issue that I was seeing when using
my own user-defined Action in combination with the default option of the add\_argument method
call.

Here is the final implementation of the DirectoryAction class.

```python
import argparse

class DirectoryAction(argparse.Action):
    def __init__(self, option_strings, dest, nargs='?', **kwargs):
        if nargs != '?':
            raise ValueError(f"nargs = {nargs} is not allowed")
        super(DirectoryAction, self).__init__(option_strings, dest, nargs, kwargs)
        # Determine if a default value is associated with this argument action
        if kwargs['default'] is not None:
            self.default = kwargs['default']
 
    def __call__(self, parser, namespace, values, option_string=None):
        if not os.path.isdir(values):
            raise ValueError('{} has to be a directory'.format(values))
        setattr(namespace, self.dest, values)
```

Note that the initialization method checks if the *default* value was passed to it and it then
sets the DirectoryAction *default attribute* to that value.  This simple solution allowed the
DirectoryAction to correctly use the default option passed to the add\_argument method.

While the above the updated implementation that resolves the issue that I encountered when I
initially tried to use the *default value* feature with a user-defined Action class.  I then
decided to see what happens if I define the above DirectoryAction class \_\_init\_\_ method
by expecting all of the default parameters associated within a user-defined Action class.  Thus,
I created the following enhanced DirectoryAction class.

```python
import argparse

class DirectoryAction(argparse.Action):
    def __init__(self, option_strings, dest, nargs='?', const=None, default=None, type=None,
                 choices=None, required=False, help=None, metaver=None, deprecated=False, **kwargs):

        if nargs != '?':
            raise ValueError(f"nargs = {nargs} is not allowed")
        super(DirectoryAction, self).__init__(option_strings, dest, nargs, const, default, type,
                                              choices, required, help, metaver, deprecated, kwargs)
 
    def __call__(self, parser, namespace, values, option_string=None):
        if not os.path.isdir(values):
            raise ValueError(f'{values} has to be a directory')
        setattr(namespace, self.dest, values)
```

I then ran the test using the above update to the DirectoryAction user-defined sub-class and the
passed *default value* was applied to the associated attribute.  Thus, it seems that forwarding
the Action parameters instead of using the *kwargs* parameter will properly assign the
appropriate Action attributes.

The above solution made me wonder about one other option that I thought of trying.  I noticed that
I was forwarding the *kwargs* parameter to the super class without include the \*\* prefix.  I then
wondered what would happen if I tried to forward the kwargs to the super class by prefixing it with
\*\*.  I then updated the above implementation as follows.

```python
import argparse

class DirectoryAction(argparse.Action):
    def __init__(self, option_strings, dest, nargs='?', **kwargs):

        if nargs != '?':
            raise ValueError(f"nargs = {nargs} is not allowed")
        super(DirectoryAction, self).__init__(option_strings, dest, nargs, **kwargs)
 
    def __call__(self, parser, namespace, values, option_string=None):
        if not os.path.isdir(values):
            raise ValueError(f'{values} has to be a directory')
        setattr(namespace, self.dest, values)
```

I then ran the test using the above update to the DirectoryAction user-defined sub-class and the
passed *default value* was applied to the associated *default* attribute of the Action class.  I
realized that all of my previous versions of the DirectoryAction sub-class was not required because
of the my misunderstanding of how to forward the kwargs.  The above implementation became the one
that I have been using.

Conclusion, is that one can use one of the last three solutions to insure that the default value is
passed to the add\_argument method will be used by the argparse package. Yet,the one solution that
one should use is the last implementation that correctly uses the *kwargs* parameter by forwarding
the kwargs by passing it as *\*\*kwargs* to the super class constructor.

I hope that this little article will help others better understand how to implement an Action
in combination with a default value.  While this article focused on how to get the Action super class
to set its default attribute.  We can see that the implementation will also be able to set the other
attributes of the Action super class.  Who knew that adding a single parameter would enlight me more
than expected.

