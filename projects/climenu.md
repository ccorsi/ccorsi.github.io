---
title: Command Line Menu
css: "/assets/css/table.css"
sidebar: projects-project
---

The Command Line Menu Python package can be used to generate a command line Python application that uses a character
based menu.  This simple package was inspired during the time that I started to learn about Machine Learning.  While
implementing the different projects while going through a book.  I realized that it wasn't a simple task to remember
which project to run.  While the prospect of aggregating the different projects within a menu driven gui
implementation wasn't what I wanted to spend my time.  The concept of creating a action based command line menu
became more appealing to me.  This is thus the outcome of that effort.

The Command Line Menu Python package was designed such that it is easy to create menu listing that can be easily
used.  We will then start with explaining how one can go about installing that package.  We wiil then look at
several examples that will display the different features of the command line menu itself.

## Installation

The Command Line Menu Python package is available using pip.  You can then install the latest version of the
command line menu using the following pip command.

```sh
$ pip install menucli
```

After that you can then check if the command line menu was properly installed using the following command.

```sh
c:\ python
Python 3.9.0 (tags/v3.9.0:9cf6752, Oct  5 2020, 15:34:40) [MSC v.1927 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> from menucli import create_menu
>>> menu = create_menu('Menu', 'Exit')
>>> menu
<menucli._TopMenuItem object at 0x000001B669EF7550>
>>> menu.show()

Menu: Menu

        1 - Exit

Select one of the above option: 1
>>>
```

If the above command executes successfully then you have successfully installed the command line menu package
on your system.  Let us now turn to create several types of menus.

## Examples

This section will contain different examples on the use of the command line menu package.  The examples will
progressively add to each prior example until we've created a menu that contains all of the different features
that one can used using the command line menu package.

### How Create a Top Level Menu

Let us then start by creating a top level menu that will be used to execute the menu actions that we will be
adding to the menu.   We will then create a top level menu using the
<code>create_menu([title],[exit title])</code> function as follows.

```python
from menucli import create_menu

menu = create_menu('Main Menu', 'Exit')
```

The above simple command will then create a top level menu that you can use add different actions that one
would like to be able to manage.  The defined menu above requires two parameters.

| Parameter | Type | Description |
| :-- | :-- | :-- |
| Title | string | The title displayed of this menu |
| Exit Text | string | The text associated to the exit command for this menu |

The above parameter are self explanatory but required to be able to start using the created menu.  The
above menu definition is only the definition of the created menu.  It will not be put into action unless
you can the *menu* <code>show()</code> function.  The show function would then display the following.

```sh
>>> menu.show()

Menu: Main Menu

        1 - Exit

Select one of the above option: 1
```

Now that we've created the top-level menu.  We now look at how one can go about adding menu items to the
menu above.

### How to Create a Sub Menu

We now look at how one can go about creating a sub menu giving the defined menu above.  This is done using
the <code>create_submenu([title],[exit_text],[menu])</code> function.  Let us then extend the above example with the addition of a
sub menu to the top level "Main Menu" menu created above.

```python
from menucli import create_menu, create_submenu
...

submenu = create_submenu('Sub Menu', 'Exit', menu)
```

The above example creates a sub menu that is associated to the top level menu instance that is passed to
the create_submenu function.  The returned submenu instance can the be used to add actions associated with
that particular submenu instance.  The <code>create_submenu</code> function requires up to three parameters,
where the first two are required as follows.

| Parameter | Type | Description | Required | Default |
| :-- | :-- | :-- | :-- | :-- |
| Title | string | The title displayed of this menu | Yes | |
| Exit Text | string | The text associated to the exit command for this menu | Yes | |
| Parent Menu | Menu instance | The parent menu for the given sub menu | No | None |

While the above explains the different parameters of the function.  The returned instance will not contain an
actions that can be performed besides stepping from the current menu to its parent menu.  While the above example
will only move from the submenu to its parent menu.  The returned submenu can also be passed as parameter to the
create_submenu function to create a submenu off of that submenu.  For instance.

```python
from menucli import create_menu, create_submenu
...

subsubmenu = create_submenu('Sub Sub Menu', 'Exit', submenu)
```

The above example provides the ability to travel through multiple menu levels without having to exit.  Thus
providing one with a flexible means to perform several actions instead of being limited to a single action. Note
that the Exit menu item of the submenu performs a similar task as the Exit menu item of the top level menu.
These menu items will then exit the menu all together and will require one to call the top-level menu show
function.

While we've have shown how to create a top level menu and its associated sub menu.  We have not shown how to
create an actionable menu items associated with a given top level menu or its sub menus.

## How to Create a Menu Action

We are now going to look at the how to create an action associated to a menu item.   These actions can not
live by themselves and require a menu item associated to them.  These menu items can be the returned items
from the <code>create_menu</code> and <code>create_submenu</code> function calls.  These actions will then
be added to the list of menu options that one can choose from for the given menu item.  These menu actions
are created using the <code>add_menu_item_action([menu_item],[title],[action],[next_menu_item])</code>
function.  The parameters are then described as follows.

| Parameter | Type | Description |
| :-- | :-- | :-- |
| Menu Item | MenuItem | The menu item that this action is associated to |
| Title | string | The title displayed for this action |
| Action | function or class instance |  A function or callable class that will be called when selected |
| Next Menu Item | MenuItem | The menu item that will be referenced after executing the passed action |

The above states that the passed action will be associated to the passed menu item.  Upon executing the
action the next menu item will be called upon completing the action.  The function provides flexibility
such that one is not limited to returning to the passed menu item.  One can then choose to return to
whichever parent menu after executing the associated action.

Let us then look at a simple example of creating a menu item with an action associated to it.

```python
from menucli import create_menu, create_submenu, add_menu_item_action
...
def simpleAction():
    print('Hello, world')

add_menu_item_action(submenu, 'Print', simpleAction, menu)

```

The above will add a menu item 'Print' to the passed submenu menu.  Upon executing the simpleAction the
passed menu menu will the displayed.  The above example shows one way of using the function to add a
menu item action.    We need to then describe what types of actions can be passed to this function.  There
are two types of acceptable actions that the <code>add_menu_item_action</code> function expects.  They can
either be a regular function or a callable class.

### Using an Action Function

A valid action function that can be passed to the <code>add_menu_item_action</code> function is defined
as follows.

```python
def action():
    ...

```

The above action function doesn't expect any parameters to be passed since now will be passed when the
function is called when it is selected from the menu.  Thus, if a user would require something passed
to the action.  They will have to create a function that already references the required data prior to
passed it to the <code>add_menu_item_action</code> function.  Let us then give an example of two types
of action functions.

```python
def simple_action():
    print('Hello, world')

```

The above <code>simple_action()</code> function will just display 'Hello, world' when it is selected.
Thou the above is pretty simple, it does lend one to be able to perform more lengthy actions that
can be executed within a given.  Let us given an example where user input is required when selecting
a given action.

```python
count = 0

def inc_action():
    global count
    count = count + 1

def print_action():
    global count
    print(count)
```

The above actions can be associaged to their own menu items where one of the menu items will call the
<code>inc_action</code> and the other will call the <code>print_action</code> action functions.  The
above technique call also be defined using callable classes.  We will discuss this next

### Using a Callble Class

A callable action class can be used with respect to menu actions.  The callable action class will need
to define the callable function <code>__call__()</code> for it to be associated with a menu action.
Thus the callable action class will look like.

```python
class ActionClass(object):
    ...
    def __call__(self):
        ...
    ...
```

The above callable action class shows that you need to implement the <code>__call__(self)</code> class
function that only expects the *self* parameter.  Note that the class <code>__init__()</code> was not
shown since you aren't required to define a particular constructor.  You are then free to define any
type of initialization function.  Let us then look at an example that doesn't need anything passed to
the callable action class and an example that does require something passed.

Here is an example of a simple callable action class.

```python
class PrintAction(object):

    def __init__(self):
        pass

    def __call__(self):
        print('Hello, world')

```

The above callable action can be used to print 'Hello, world' when a menu item was selected.

Here is an example of a external field access.

```python
class Message(object):

    def __init__(self):
        self.msg = 'Hello, world'

    def get(self):
        return self.msg

    def set(self,msg):
        self.msg = msg

class SetMessageAction(object):

    def __init__(self,msg):
        self.msg = msg

    def __call__(self):
        msg = input('Enter message: ')
        self.msg.set(msg)

class PrintMessageAction(object):

    def __init__(self,msg):
        self.msg = msg

    def __call__(self):
        print(self.msg.get())
```

The above classes will use a common instance to store and retreive a message.

We have then completely described how one can go about creating and extending a command line
menu using the above three functions.  We are now going to create a menu that will use all of
the above functions.

## Full Menu Example

Let us then create a full fledge example that will incorporate all of what you can do with the
command line menu package.

Coming soon....

