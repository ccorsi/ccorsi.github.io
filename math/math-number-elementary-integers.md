---
title: Integers
author: Claudio Corsi
tags: [ number theory, elementary number theory, integers ]
permalink: /math/number/elementary/integers.htm
debug: true
sidebar: math-number-elementary-integers
chapter: 1
---

This section will deal specifically with integers within the context of elementary number theory.  I will start with a
definition of what are integers.

{% assign caption="Integers" %}
{% capture body %}Integers are defined as the set
    $$\mathbb{Z} = \{...,-2,-1,0,1,2,...\}$$
{% endcapture %}

{% include definition.html content=body %}

Now that we have a definition of what integers are.  We can look at some other definitions.

{% assign caption="Least-Integer Principle" %}
{% capture body %}A nonempty set of integers that is bounded below contains a smallest element.
{% endcapture %}

{% include definition.html content=body %}

An example of such a set is $$X \colon= \{x \in \mathbb{Z} \mid x > 1\}$$.

{% assign caption="Greatest-Integer Principle" %}
{% capture body %}A nonempty set of integers that is bounded above contains a largest element.
{% endcapture %}

{% include definition.html content=body %}

An example of such a set is $$Y \colon= \{y \in \mathbb{Z} \mid y < 1\}$$.

{% assign caption=nil %}
{% capture body %}We say that <b>a</b> divides <b>b</b> (written \(a \mid b\)) if and only if there is an integer
<b>d</b> such that <b>ad</b> = <b>b</b>.
{% endcapture %}

{% include definition.html content=body %}

The above definition pertains to a combination of numbers that are divisible.  I can also start that is <b>a</b> does
not divide <b>b</b> then we can state this as $$a \nmid b$$.

Now that I have defined some elementary definitions above.  We can start by looking at proving the following.

{% capture body %}If \(a \mid b\) and \(b \mid c\) then \(a \mid c\).
{% endcapture %}

{% capture proof %}From the definition we know that there exists a <b>q</b> and <b>r</b> such that <b>aq = b</b> and <b>br = c</b>.  Thus we can then state that <b>aqr = br</b>.  We can then replace <b>qr</b> with <b>s</b> and <b>br</b> with <b>c</b>.  We then have <b>as = c</b> which implies that \(a \mid c\).
{% endcapture %}

{% include theorem.html content=body proof=proof %}

We can then use the above information to prove the following

{% capture body %}If \(d \mid a\) and \(d \mid b\), then \(d \mid (a + b)\).{% endcapture %}

{% capture proof %}From the definition, we know that there are integers <b>q</b> and  <b>r</b> such that
    $$dq = a$$ $$\text{ and }$$ $$dr = b.$$
Thus
    $$a + b = d(q + r),$$
so from the definition again, \(d \mid (a + b)\).
{% endcapture %}

{% include lemma.html content=body proof=proof %}

In the same way, we can prove

{% capture body %}If \(d \mid a_1, d \mid a_2, \dots d \mid a_n\), then \(d \mid (c_1a_1 + c_2a_2 + \dots + c_na_n)\) for any integers \(c_1,c_2, \dots c_n\).
{% endcapture %}

{% capture proof %}From the definition, there are integers \(q_1, q_2, \dots, q_n\) such that \(a_1 = dq_1, a_2 = dq_2,
\dots, a_n = dq_n\). Thus
$$c_1a_1 + c_2a_2 + \dots + c_nq_n,$$
and from the definition again, \(d \mid c_1a_1 + c_2a_2 + \dots + c_na_n\).
{% endcapture %}

{% include lemma.html content=body proof=proof %}

Let us look at an example of how we can use the above lemma.  Let us then see if it is possible to have 100 coins, made
up of <em>c</em> pennies, <em>d</em> dimes and <em>q</em> quaters, be worth $5.00.  Thus,

$$c + d + q = 100$$

$$\text{and}$$

$$c + 10d + 25q = 500$$

We can do the following:

$$c + 10d + 25q - (c + d + q) = 500 - 100$$

which gives

$$9d + 24q = 400$$

Since $$3 \mid 9$$ and $$3 \mid 24$$ the above lemma says that $$3 \mid 9d + 24q$$ which implies that $$3 \mid 400$$
which is impossible since 3 isn't a factor of 400.

{% capture body %}If \(d \mid a\) then \(d \mid ca\) for any integer <em>c</em>.{% endcapture %}

{% capture proof %}From the definition, there are integers....
{% endcapture %}

{% include lemma.html content=body proof=proof %}
