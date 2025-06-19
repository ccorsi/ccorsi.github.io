---
title: Design by Contract Decorator
css: "/assets/css/table.css"
sidebar: projects-project
---

The Design by Contract Decorator Python package was created to be able to understand how Python decorators work.  I
was looking for something that would be interesting to me and can also be useful to others.  Thus, the creation of
a Design by Contract decorator.

This decorator provides the user with the ability to associate conditional requirements for the different paramters
associated with a function and/or class method.   One can choose to check things like type information about the
passed value and/or other contractual requirements for the passed values.  For instance, you might expect that a
number is passed to the method and that the value should be greater than 0.  You can add the decorator that will
be able to determine if the passed number is greater than 0.  It will generate an exception if this is not the
case.  This would then allow the developers to better determine where the problem is located within their code
base.

To be continued...

