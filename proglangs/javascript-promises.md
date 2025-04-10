---
title: Promise
subtitle: An Asynchronous Operation
permalink: /proglangs/javascript/promise.html
sidebar: proglangs-javascript-promise
---

Since JavaScript uses a single thread event model.  Tasks that need to wait for outside response
like network or I/O communications have to be able to yield to other actions that can be
performed immediately.  These tasks then need to be processed differently and this is why these
tasks are executed asynchronously.  This is where the Promise object comes into play.  A
Promise instance tells the developer that the action requires work to be done by an outside
feature like reading a file.  The JavaScript engine will then place the object on a wait queue
that waits until the external action has been completed.  It then executes the next step in the
call.  When a Promise instance is created.  It can be in any of the following states.

- *pending*: initial state
- *fulfilled*: the method call was successfully completed
- *rejected*: the method call wasn't successfully completed

Let us look at these different states before we talk about how to define and use a Promise instance.

## Pending

A Promise is in a *pending* state whenever the method has not completed successfully nor has it
completed unsuccessfully.  This is the case whenever the Promise object was initially created and
placed on the wait queue.  It is also in this state when the defined method has not completed its
task or that an error was not generated.  Basically, this just means that the function is in
progress.

## Fulfilled

The Promise instance is in a fulfilled state whenever the defined function has completed its task
while not generating any exceptions along the way.  Thus, the function has completed and may or may
not provide a return value.  The processing of the returned value of a Promise can be processed
using one of two techniques.  There is the use of the <code>await</code> feature or the use of the
returned Promise instance <code>then(onFulfilled, onRejected)</code> method.  The description of
this method will be explained when we look at the Promise object itself.  For now, we just need to
understand that there are two ways of processing the function's returned value.

## Rejected

The Promise instance is in a rejected state whenever it uses the passed reject callback to the
Promise constructor which is passed a rejection reason.  The passed reason can be anything and is
not confined to an instance of an Error object.  The error can then be processed using several
mechanism that the Promise object provides.  There is the use of the
<code>then(onFulfilled, onRejected)</code> callback where you pass a defined <code>onRejected</code>
callback that is passed the reason for why the call failed.  There is also the
<code>catch(onRejected)</code> callback where the reason is passed to that callback.  Finally,
there is also the use of the <code>await</code> feature where you wrap the call within a
<code>try</code>/<code>catch</code> block.  These are the only ways that you can process errors
encountered during the call of a function that returns a Promise instance.

We are now ready to look at the Promise object itself.

## Promise

The Promise object provides different means to be able to execute a function that doesn't require the
caller to wait for it to complete prior to continuing to perform other tasks.  We will then take a look
at the different features of the Promise and expand on how to implement and use those features.

### Promise((resolve,reject))

The constructor of the Promise object will provide two callbacks that can be used to state that the
actions have been resolved, (fulfilled), or that the actions have been rejected.  When a Promise
instance is created.  The actions that that Promise will execute will be contained within the passed
callback that will be passed a <code>resolved</code> and <code>rejected</code> callback functions.
Thus, a Promise instance is created as:

```javascript
const p = new Promise((resolve, rejected) => {
    ...
    if (...)
        resolve(...)
    else
        reject(...)
})
```

The above definition requires some explanation before we can then look at the other functions of the
Promise object.  You will note that the constructor expects a callback that will be passed two callbacks.
One used when the actions executed within the Promise completed successfully, <code>resolve</code>, and
the case when the actions executed within the Promise didn't complete successfully, <code>rejected</code>.

Let us then look at each function starting with the <code>resolve</code> callback.  The <code>resolve</code>
callback is used to inform the Promise instance that the executed actions were successful.  The user can pass
the returning value to the Promise instance using the <code>resolve</code> function like the following.

```javascript
const p =  new Promise((resolve, reject) => {
    resolve(101)
})
```

The above function will return the value of 101 upon completion of the Promise instance.  The return value
can then be processed using the <code>await</code> syntax or using the Promise <code>then</code> function.
This will be explained within its own section below.

Before looking into the <code>reject</code> function callback.  I want to state that the <code>resolve</code>
callback can also return a new instance of a Promise object.  The act of returning another Promise instance
still signifies that the Promise has been **"resolved"** but it is still not **"settled"**.  A Promise is
considered **"settled"** when the passed **resolved value** is not a Promise instance.  Here is an example of
returning a Promise.

```javascript
const p = new Promise((resolve, rejected) => {
    ...
    resolve(new Promise((innerResolve, innerRejected)) => {
        ....
    })
})
```

The above Promise instance is returning a second inner Promise instance that will perform some set of
actions.   The returned resolved Promise instance will be the returned instance of a Promise instance that
wraps around a non-Promise value in the prior example of the resolve function.

While the <code>reject</code> function can be use to inform the caller that the actions did not execute
successfully like in the following.

```javascript
const p = new Promise((resolve, reject) => {
    reject('Incorrect input')
})
```

The above function will generate a error with the reason *'Incorrect input'* associated to it.  The error
can be processed using the <code>await</code> syntax wrapped within a <code>try</code>/<code>catch</code>
block or using the Promise <code>catch</code> or <code>then</code> functions.  The
<code>catch(onRejected)</code> function expects a callback that will be passed the reason.  While the
<code>then(onFulfilled, onRejected)</code> function will expect the onRejected callback that will be passed
the reason.  We will further look into the above Promise functions and await syntax in their own section below.

## Using the await and async Syntax

The following section will explain the use of the <code>async</code> and <code>await</code> syntax that
simplifies the use of the Promise instance.

The JavaScript standard was augmented to include the <code>async</code> and <code>await</code> syntax to
simplify the use of the Promise instance.  The inclusion of these syntax sugar allows one the ability to
create cleaner code when using Promises.  This allow others to have a better understanding of how
one can use Promises.  Let us then look at how one can go about using the above syntax.  We will start
by providing the Promise equivalent version first and then transform it into the
<code>async</code>/<code>await</code> use case.

```javascript
function callme() {
    return new Promise((resolve,reject) => {
        ....
    })
}

callme()
    .then(() => { console.log('function call completed successfully.') })
    .catch((error) => { console.error(`An error was encountered: ${error}`) })
```

The above code <code>callme()</code> will return a Promise instance that will be used to determine if the
call was fulfilled or not.  Let us now look at how one can go ahead and replace the above with the
<code>async</code> and <code>await</code> syntax.

```javascript
async function callme() {
    ...
}

try {
    await callme()
    console.log('function call completed successfully.')
} catch (error) {
    console.error(`An error was encountered: ${error}`)
}
```

The above code is equivalent to the prior code snippet.  The above code is cleaner than the prior one
and is clearer in its use case.  Thou I have shown how you can use the two different ways of creating
and using Promises.  This doesn't imply that one can't combine the two techniques.  For instance, we
can assume that a library function <code>foo()</code> is defined as:

```javascript
function foo() {
    return new Promise((resolve,reject) => {
        ...
    })
}
```

The above doesn't limit you to only using the <code>then</code>/<code>catch</code>/<code>finally</code>
functions.  You can still use the <code>await</code> syntax like the following:

```javascript
await foo()
```

which will work just as well as using the <code>then</code> function with the returned Promise instance.

Let us now take a closer look at the different functions associated with the Promise object.

## Promise instance methods

The Promise object provides several instance and static methods that one can use to create and
process a Promise instance.

### The <code>then</code> instance method

The Promise <code>then(onFulfilled,onRejected)</code> instance method can be used to process the
fulfillment and/or rejection of the Promise instance.  This allows the user to be able to associate a
callback that will be called upon successful fulfillment of the Promise.  The callback will be passed
the Promise resulting value.  This value can be anything from a void to any type of data.  The
onFulfilled callback will then be able to process this value. The onRejected callback will also be
passed an error value that the callback will be able to process.  Let us look at each of these callbacks
individually.

#### onFulfilled callback

The <code>onFulfilled</code> callback will have the following syntax.

```javascript
function onFulfilled( value ) {
    ...
}
```

The function *value* parameter can be of any type that the Promise has been passed through the
<code>resolve</code> callback. This can be anything from a void type to a complex type.  The only caveat
is that it can only be a single parameter and you are not allowed to passed multiple values to the
<code>resolve</code> function.  This doesn't mean that you can't return an *iterable value* like any array.
Let us then look at several examples that will clarify what I just mentioned above.  Let us start with a
Promise that returns a void.

```javascript
new Promise((resolve) => {
    console.log(`log a message`)
    resolve()
}).then(() => {
    console.log('completed')
})
```

Note that the above Promise will not be returning any value, aka void, so the defined <code>onFulfilled</code>
callback doesn't require us to define a passed value since none will be passed.

Let us now look at a case where a simple value is return by the defined Promise instance.

```javascript
new Promise((resolve) => {
    resolve(101)
}).then( (value) => {
    console.log(`returned: ${value}`)
})
```

The above <code>onFulfilled</code> callback will be passed the value *101* which is then displayed to
standard out.  While the above is a simple integer.  The callback can be passed any single type that the defined
Promise instance wants to return.  Let us look at a example that returns a complex data type.

```javascript
new Promise((resolve) => {
    resolve({
        'name': 'id',
        'type': 'string',
        'value': 'This is a string'
    })
}).then( (value) => {
    console.log(`returned: ${value}`)
})
```

The above Promise will be returning a complex object that contains the name, type and value attributes.
The fulfilled callback will then be passed this value to it and it can then use that information to
perform its own actions.

While that above example shows how one can go about returning different types of data to be passed to the
defined <code>onFulfilled</code> callback.  Let us look at a different example that will assign results to
unique parameters.

```javascript
new Promise((resolve) => {
    resolve([101, 'This is a string'])
}).then( (values) => {
    values.forEach((value) => {
        console.log(`value: ${value}`)
    })
})
```

The above shows you how you can return a *iterable* instance that contains different entry types. While
the above is a simple solution for processing the returned values.  We can create a fulfilled callback
that knows what types of values are returned and assign them to specific variables like the following.

```javascript
new Promise((resolve) => {
    resolve([101, 'This is a string'])
}).then( ([value, msg]) => {
    console.log(`returned: value: ${value} with msg: ${msg}`)
})
```

The above example fulfilled callback knows that the return value is contained within an array and
that the first entry is an integer and the second a string.  It then assigns those values to the
local variables value and msg.

Note that the above fulfilled callback doesn't return any values after completing the callback.  The
callback can return other values that will be forwarded to other calls.  The <code>then</code> method
will return a Promise instance that can be defined in several ways.

- Return a value using the <code>return</code> method
- Return nothing
- Throws an error
- Return a Promise instance

The <code>then</code> method will return a wrapped Promise instance with the first three cases while the
last case the defined Promise will be returned.  Note that returning a Promise can mean anything from
it being *fulfilled*, *rejected* or *pending*.

We have now looked at how one can go about processing the returned value from a defined Promise
instance.  We now look at how we can use the <code>onRejected</code> callback.

#### onRejected callback

The <code>onRejected</code> callback will have the following syntax.

```javascript
function onRejected( reason ) {
    ...
}
```

The above rejected callback function syntax will be used whenever a Promise was not successful.
The reason will be passed to the callback function that was passed to the Promise
<code>then</code> and/or <code>catch</code> methods.  While the reason will be thrown when
using the <code>await</code> syntax.

Note that the type of the reason parameter is not limited to it being a exception.  It can be any
type that is passed to the Promise instance reject callback.

Note that the above rejected callback doesn't return any values after completing the callback.  The
callback can return other values that will be forwarded to other calls.  The <code>then</code> method
will return a Promise instance that can be defined in several ways.

- Return a value using the <code>return</code> method
- Return nothing
- Throws an error
- Return a Promise instance

The <code>then</code> method will return a wrapped Promise instance with the first three cases while the
last case the defined Promise will be returned.  Note that returning a Promise can mean anything from
it being fulfilled, rejected or pending.

Let us now look at an example using the <code>onRejected</code> callback.

```javascript
new Promise((resolve, reject) => {
    reject('This is an error')
}).then(
    (value) => {
        console.log(`returned value: ${value}`)
    },
    (error) => {
        console.error(`generated error: ${error}`)
})
```

The above Promise implementation will then pass the string *'This is an error'* as the error
associated with the failure of the executed Promise.  While the above code uses the *then* callback
definition.  This can also be processed when using the *await* syntax.

```javascript
try {
    await new Promise((resolve, reject) => {
        reject('This is an error')
    })
} catch (error) {
    console.error(`generated error: ${error}`)
}
```

The above code is similar to the prior code snippet and will produce the same output.  While the
above example uses a Promise. This will generate the same result if we use the *async* syntax like the
following.

```javascript
async function callme() {
    throw 'This is an error'
}
try {
    await callme()
} catch (error) {
    console.error(`generated error: ${error}`)
}
```

Again, the above will generate the same output as the prior examples.

### The <code>catch</code> instance method

We've seen what we can do with the Promise <code>then</code> method.  We will then take a look at
what we can do with the Promise <code>catch</code> method.  This method can be used to process
errors that have been raised by the implemented Promise instance.  The passed callback to
the <code>catch</code> method is the same as the <code>then</code> onRejected callback.  Thus,
the <code>catch</code> onRejected callback syntax is.

```javascript
function onRejected( error ) {
    ...
}
```

Thus, the <code>then</code> examples using the onRejected callback can then be implemented as.

```javascript
new Promise((resolve, reject) => {
    reject('This is an error')
}).catch(
    (error) => {
        console.error(`generated error: ${error}`)
})
```

but when using the <code>await</code> syntax you will be using the same syntax as the above
<code>then</code> example.

```javascript
async function callme() {
    throw 'This is an error'
}
try {
    await callme()
} catch (error) {
    console.error(`generated error: ${error}`)
}
```

As is shown above, the syntax is similar in every way as with the use of the <code>then</code> method.
The difference is that the <code>catch</code> method allows you to only process error associated with
the Promise instance.  The use of the <code>catch</code> method is better whenever the Promise instance
doesn't return a result but you want to be able to handle only errors associated with the Promise.

Note that the passed function to the <code>catch</code> method can return the same set of values as the
passed callback functions to the <code>then</code> method.  For more information look at the
<code>then</code> or <code>catch</code> sections.

We've looked at the <code>then</code> and <code>catch</code> methods.  We are now going to look
at the remaining <code>finally</code> instance method.

### The <code>finally</code> instance method

The Promise <code>finally</code> instance method can be used to determine when the Promise has
completed irrespective of it being fulfilled or rejected.  This call will always be called after the
<code>then</code> or <code>catch</code> callbacks have been called.  The <code>finally</code>  callback
syntax is.

```javascript
function onFinally() {
    ...
}
```

Note that the <code>finally</code> callback doesn't get passed any data since this is not used to process
any of the resulting outcome of the Promise instance.  Thus, you need not worry about processing
passed values and just use the callback to determine when the Promise instance was completed and
you can then use that action to perform another action if this is something that is required.  Let
us look at an example of the onFinally callback.

```javascript
new Promise((resolve, reject) => {
    ...
}).finally(() => { console.log('Promise was completed')})
```

The defined onFinally method will then be called when the Promise has settled which is after the
<code>then</code> and <code>catch</code> callbacks have been called.  Let us look at an example that succeeds.

```javascript
new Promise((resolve, reject) => {
    resolve(101)
}).then((value) => { console.log(`result: ${value}`) },
        (error) => { console.log(`error: ${error}`) })
  .finally(() => { console.log('Promise was completed')})
```

The above will produce the following output.

```shell
result: 101
Promise was completed
```

As you can see the output of the finally will be displayed after the output of the then onFulfilled
callback.

We are then done with looking at the Promise instance methods.  Let us now turn to the Promise static
methods.  We will look at what they are, their usefulness and when to use them.

## Promise static methods

The Promise object contains several static methods that one can use in conjuntion with the creation
and use of Promise instances.  Let us look at each method in turn.

### The <code>reject</code> static method

The Promise static method <code>reject</code> is used to return a Promise instance that will use
the <code>then</code> and <code>catch</code> onRejected callback.  The reject method is used when you
want to return a Promise instance that will describe a rejected reason.  Here is an example using the
<code>reject</code> static method.

```javascript
Promise.reject(new Error('failed')).
    then((result) => { console.log(`result: ${result}`) },
        (reason) => { console.log(`reason: ${reason}`) })
```

The above call will cause the rejected callback to be called and the created Error instance passed to
the reject static method will be passed to the onRejected methods passed to the onRejected functions
passed to <code>then</code> and <code>catch</code> methods.

### The <code>resolve</code> static method

The Promise static method <code>resolve</code> is used to return a Promise instance that will use
the <code>then</code> onFulfilled callback.  The use of the resolve method is when you want to
return a Promise instance that to forward a result to the calling user.  Here is an example using
the resolve static method.

```javascript
Promise.resolve(101).then(
    (result) => { console.log(`result: ${result}`) },
    (reason) => { console.log(`reason: ${reason}`) }
)
```

The above call to resolve will return a Promise instance that will then pass the value 101 to the
onFulfilled callback passed to the <code>then</code>.  In the above case the string
**<q>result: 101</q>** will be printed to standard out.

### The <code>all</code> static method

The Promise static method <code>all</code> is used to determine if one or more Promise have successfully
completed the actions associated to the passed Promises.  The <code>all</code> static method will be
passed an iterable of Promises or values.  It will then return a single Promise instance that can be used
to determine if all of the Promises completed successfully or if at least one of them was rejected.  Thus
the returned Promise can be passed a onFulfilled and onRejected callbacks to the <code>then</code> method
of the returned Promise instance.  Note that when one of the passed Promises was rejected that rejected
reason is passed to the onRejected callback but will not inform the callback which Promise was the one that
generated the rejection.  Here is an example using the <code>all</code> static method.

```javascript
Promise.all([Promise.resolve(101), Promise.resolve(7)]).then( (result) => { console.log('result:', result) },
    (reason) => { console.log('reason:', reason) })
```

The above code would generate the following output.

```shell
result: [ 101, 7 ]
```

While the above example passed Promise instances to the Promise <code>all</code> static method.  You are
not limited to passed Promise instances.  You can also pass values and these values will each be wrapped
within a Promise instance.

The <code>all</code> static method is useful in the case that you have multiple Promises that need to be
completed before you are able to continue to process more actions.  This can also be the case that you
are trying improve concurrency by executing multiple asynchronous tasks that are mutually distinctive
but connected to the work that needs to be completed.

### The <code>allSettled</code> static method

The Promise <code>allSettled</code> static method is used to aggregate the settled actions for each of the
passed Promises and/or values.  The resulting information is then placed within an iterable array that
contains an instance that contains the following attributes.

| Name | Description |
| :---: | :--- |
| status | Will contain either "fulfilled" or "rejected" |
| value | will contain the value returned from the fulfilled Promise |
| reason |  will contain the reason for the rejected Promise |

Thus, one can determine if the nth Promise was fulfilled or rejected using the status attribute of the
passed object within the returned iterable.  Here is an example of how you can use this static method.

```javascript
Promise.allSettled([Promise.resolve(101), Promise.reject('Failed')]).then((results) => {
    results.forEach((result) => {
        switch(result.status) {
            case 'fulfilled':
                console.log('result:', result.value)
                break
            case 'rejected':
                console.log('reason:', result.reason)
                break
        }
    })
})
```

The above example would then produce the following output.

```shell
result: 101
reason: Failed
```

The above static method is useful when you want to be able to perform certain actions depending on a
collection of Promises.  This method allows you to be able to determine which Promise was rejected
compared to the <code>all</code> static method that doesn't provide information about which Promise
was rejected nor how many of the Promises were rejected.

### The <code>any</code> static method

The Promise <code>any</code> static method can be used to determine what happened to the first Promise
of a set of Promises that were fulfilled or pending.  The returned Promise will either be passed the value
of the first Promise that was fulfilled or it will pass an AggregateError if all of the passed Promises
were rejected.  Here is an example using the <code>any</code> static method.

```javascript
Promise.any([Promise.reject('Failed'), Promise.resolve(101)]).then(
    (result) => {
        console.log('result:', result)
    },
    (reason) => {
        console.log('reason:', reason)
    })
```

The above will pass the value of 101 to the onFulfilled callback and ignore the rejected Promise since
at least one of the Promise was fulfilled.  The output <q>result: 101</q> will be printed to standard
out.  This method is then useful when one only needs to know if at least one of the passed Promise was
fulfilled.  While not requiring knowledge if any of the other Promises were fulfilled or rejected.

### The <code>race</code> static method

The Promise <code>race</code> static method is used to determine which of the passed iterable
Promises completed first.  This will then become the settled state of the iterable set of Promises.
This doesn't imply that all of the passed Promise were fulfilled nor rejected.  It just informs you
of how the first completed Promise settled.  Here is an example

```javascript
const p1 = new Promise((resolve, reject) => {
    setTimeout(resolve, 1000, 'second')
})
const p2 = new Promise((resolve, reject) => {
    setTimeout(resolve, 100, 'first')
})

Promise.race([p1, p2]).then((result) => {
    console.log('result:', result)
})
```

The above would then produce the following output.

```shell
result: first
```

This is because the p2 Promise was executed after 100ms compared to the p1 Promise being executed
after 1000ms.  If the Promise was rejected before it was fulfilled then the rejected callback would
be called instead of the fulfilled callback.  This method can then be used to determine which
Promise completed first and how it settled.

### The <code>withResolvers</code> static method

The Promise <code>withResolvers</code> static method will return a plain object that contains the
following fields.

| Name | Description |
| :--- | :--- |
| promise | A Promise instance that can be used to process settled actions |
| resolve | A function used to resolve the Promise in the promise field |
| reject | A function used to reject the Promise in the promise field |

This static method is used whenever you are unable to wrap something within a Promise.  For example,
processing a event listener cannot be wrapped within a Promise instance.  The returned plain object
can then be used to generate the required actions for a given event.  Let us then look at an example
of this static method.

```javascript
async function* readableToAsyncIterable(stream) {
  let { promise, resolve, reject } = Promise.withResolvers();
  stream.on("error", (error) => reject(error));
  stream.on("end", () => resolve());
  stream.on("readable", () => resolve());

  while (stream.readable) {
    await promise;
    let chunk;
    while ((chunk = stream.read())) {
      yield chunk;
    }
    ({ promise, resolve, reject } = Promise.withResolvers());
  }
}
```

The above example was taken from the Mozilla Developer Promise <code>withResolvers</code>
[Examples](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/withResolvers#examples){:target="_blank"}.
The example above shows that you are unable to wrap the *stream* instance within a Promise instance so
you are then obliged to use the Promise <code>withResolvers</code> static method to gain access to
the returned Promise instance resolve and rejected methods.

## Chaining

Since we have looked at the different instance and static methods associated with the Promise object.
We will now look at how we can use Promise instances to chain calls together that will ultimately
provide a final answer for a given request.

The Promise object provides the ability to chain different calls depending on the result of a given
Promise.  For instance, we can create a Promise that will settle with a given result. This result
can then be used to generate another Promise instance to produce a separate result that can then
used to perform a different task.  Let us look at an example.

```javascript
function another(option, resolve, reject) {
    if (option == 1) {
        resolve(new Promise((resolve, reject) => {
            resolve(13)
        }))
    } else {
        resolve(-2)
    }
}

async function callme(option) {
    switch (option) {
        case 'a':
            return new Promise((resolve,reject) => {
                another(1, resolve, reject)
            })
            break;
        default:
            return -1
    }
}

callme('a').then((result) => { console.log(`result: ${result}`) })
```

The above call will print out <q>result: 13</q> which is the result of chaining multiple
Promise instances within a single <code>callme</code> call.  You can also add Promise
instances that will not be returned to the caller but that are just used for something
else that isn't connected to the call.  For instance, you can create a Promise instance
that will log information pertaining to the called function for audit purposes.  The
above could be updated as follows.

```javascript
function another(option, resolve, reject) {
    if (option == 1) {
        resolve(new Promise((resolve, reject) => {
            // log passed option information to a file and/or a database
            new Promise((resolve,reject) => {
                // This Promise will not be returned to the caller and will
                // be used to store audit information that can be checked
                // later for any issues.
            })
            resolve(13)
        }))
    } else {
        resolve(-2)
    }
}

async function callme(option) {
    switch (option) {
        case 'a':
            return new Promise((resolve,reject) => {
                another(1, resolve, reject)
            })
            break
        default:
            return -1
    }
}

callme('a').then((result) => { console.log(`result: ${result}`) })
```

The <code>another</code> function above will create a Promise instance that will then
store any audit information that can be used to check for any issues with the call.

The above is an example of how one can go ahead and chain Promises together to be able
to perform a particular action for a given call.

## Conclusion

We are then done looking at the Promise object and how it can be used to get work done in an
asynchronous fashion.

If you are interested in learning more about how you can use the Promise object within your
project.  You can take a look at the
[Using promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises){:target="_blank"}
guide on Mozilla developer web site.
