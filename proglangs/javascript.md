---
title: JavaScript
sidebar: proglangs-javascript
permalink: /proglangs/javascript/javascript.html
---

This section contains information about the JavaScript programming language. JavaScript is a dynamic
programming language that was initially created for client-side web development.  It has since then
evolved into a client-side and server-side programming language.  Its appeal has propelled it into a
major programming language that has been used by countless developers.  This in and of itself makes
it hard for developers not to get acquainted with this programming language.  I, for one, have been
drawn to it by the fact that I have created some personal web pages that required using JavaScript
to dynamically update those web pages.  Even though it contains the word *Java* within its name.
It has different features that are not part of the Java programming language.  For instance,
JavaScript is a single threaded event driven environment.  Tasks that require feedback like I/O actions
end up being placed on a waiting queue that allows the JavaScript engine the opportunity to execute
another action that is ready to be processed.  These *events* are managed by the JavaScript engine and
insure that they are processed as they are available in a serialized fashion.  This make it as such
that one doesn't need to worry about synchronizing data access since this is never an issue.  This is
probably one of the biggest advantage of JavaScript over something like Java.  This ability to not
need to worry about synchronizing data access greatly simplifies the development of JavaScript
projects.  I will describe the main feature of JavaScript that allows one to take advantage of the
single threaded model that JavaScript uses.

Let us then start by taking a look at a simple JavaScript code.

```javascript
function message(msg) {
    console.log(msg)
}
```

The above simple function just prints to the console the passed message *msg*.  The function is
defined as a regular function that will be executed without requiring any waiting.  When the
JavaScript engine runs this function.  It will be executed without being place on a waiting queue.
You can think of this function as a synchronized method.  You can also define a function that
will be put on a waiting queue as follows:

```javascript
async function message(msg) {
    console.log(msg)
}
```

The difference between the prior implementation and this one is the addition of the *async* to the function
definition.  This means that upon calling this message the call will be placed on an event queue that will
then wait until the method has completed prior to it continuing its execution.  The caller will then only
be able to know when this method has completed by using the <code>await</code> syntax or by using the
returned object <code>then</code> method.  For example:

```javascript
await message('Hello, world!')
console.log('message has been displayed')

message('Hello, world!').then(() => {
    console.log('message has been displayed')
})
```

The two above calls produce similar results.  I will talk more about the use of the above syntax since
this is something that I have found interesting when using the JavaScript programming language.

To be continued....
