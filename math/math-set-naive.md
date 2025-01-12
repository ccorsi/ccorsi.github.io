---
subtitle: Set Theory
title: Naive
author: Claudio Corsi
tags: [ mathematics, naive set theory ]
permalink: /math/set/naive.htm
debug: true
sidebar: math-set-naive
chapter: 1
---

This section will be describing the naive part of set theory.  This section will be using the book from
{% include citation.html references=page.references file="math" key=7 %}.

## Basic Notation

This section will be using first-order predicate calculus with equality.  Let us then start with a definition for
the basic language that we will be using within this section of set theory.

{% capture body %}The basic language consists of all the expressions obtained from \(x=y\) and \(x \in y\), where
\(x \text{ and } y\) are any variables, by the sentential connectives \(\neg(not), \rightarrow (if...then..), \vee (or), \wedge (and), \leftrightarrow (\text{if and only if}), \text{ and the qualifiers } \exists (\text{there exists an x})\text{ and } \forall (\text{for all x})\).  This is what is called a <b>formula</b>.
{% endcapture %}

{% include definition.html content=body caption="formula" %}

Let us now define what a **free variable** is.

{% capture body %}A <b>free variable</b> of a formula is, informally, a variable occurring in that formula so that it can be given different values and the formula says something concerning the values of the variable.
{% endcapture %}

{% include definition.html content=body caption="free variable" %}

For example, $$x$$ is a *free variable* in each of the following formulas (which are not necessarily taken from set theory):

$$x < 3x,$$

$$x^2=y,$$

$$x \text{ is a real number},$$

$$\sin x > \frac{1}{2}$$

$$x$$ is not a *free variable* in the formulas:

$$\forall(x^2 \ge 0),$$

$$\neg \exists x(x \in y),$$

$$\int_0^y \sin x \text{ } dx \lt \frac{1}{2}$$

In the above cases, $$x$$ is an auxillary variable which cannot be given a definite value and which can be replaced
throughout each formula by another variable, say $$z$$, without changing the meaning of the formula. In these cases,
$$x$$ is used as a *bound variable*.

Note that $$\forall x (x^2 \ge 0)$$ is exactly what $$\forall z (z^2 \ge 0)$$ says, while $$\sin x \gt \frac{1}{2}$$
isn't the same as $$\sin z \gt \frac{1}{2}$$.  The second condition can have values of *x* and *z* that may be true
for $$\sin x \gt \frac{1}{2}$$ while being false for $$\sin z \gt \frac{1}{2}$$.

Thus, a *formula* with *free variables* says something about the values of its *free variables*.  While the above
doesn't.  We shall thus define the above as:

{% capture body %}A formula without free variables makes a statement not about the value of some particular variable,
but about the universe which the language describes.  This is called a <b>sentence</b>.
{% endcapture %}

{% include definition.html content=body caption="sentence" %}

Within this section we will then be referring to *formulas* and *sentences* as *"statements"*.

{% comment %}
The following is an example of how to use a book image to link to where it can be clicked to find more information.

[![Introduction to Real Analysis](https://dover-books-us.imgix.net/covers/9780486612263.jpg?auto=format&w=100)](https://store.doverpublications.com/products/9780486612263)

Here is a second attempt to create a link to a book using the publishers provided image.

<div class="row" style="height: 100px; width: 120px">
<a href="https://store.doverpublications.com/products/9780486612263" target="_blank" title="Introduction to Real Analysis"><img src="https://dover-books-us.imgix.net/covers/9780486612263.jpg?auto=format&w=300"></a>
</div>

This example produces an image that is 300px wide

<img src="https://dover-books-us.imgix.net/covers/9780486612263.jpg?auto=format&w=300">

This example produces an image that is 120px wide and 150px high

<div class="row" style="height: 150px; width: 120px">
<a href="https://store.doverpublications.com/products/9780486612263" target="_blank" title="Introduction to Real Analysis"><img src="https://dover-books-us.imgix.net/covers/9780486612263.jpg?auto=format&w=120&h=150"></a>
</div>

This example is the same as above without it being wrapped within a div element

<a href="https://store.doverpublications.com/products/9780486612263" target="_blank" title="Introduction to Real Analysis"><img src="https://dover-books-us.imgix.net/covers/9780486612263.jpg?auto=format&w=120&h=150"></a>

{% endcomment %}
