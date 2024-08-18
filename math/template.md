---
title: Mathematics
subtitle: Everything to do with Mathematics
author: Claudio Corsi
tags: [ mathematics, introduction ]
permalink: math/template.htm
---

{% assign chapter = 2 %}
{% comment %}
{% assign definition = 1 %}
{% assign theorem = 1 %}
{% endcomment %}

## Introduction

This page will be generated using the math layout that should provide some 
interesting mathematical equations.

{% capture defone %}
This is a simple mathematical definition. 

We are going to see what happens when we extend the definition of a mathematical statement.

Will this text be wrapped properly around the area that is being used? \(x^6\).
{% endcapture %}
{% include definition.html content=defone %}

{% comment %}
{% include definition.html content="This is a simple mathematical definition.  We are going to see what happens when we extend the definition of a mathematical statement.  Will this text be wrapped properly around the area that is being used? \(x^6\)." %}
{% endcomment %}

{% include definition.html content="This is a simple mathematical definition.  We are going to see what happens when we extend the definition of a mathematical statement.  Will this text be wrapped properly around the area that is being used? \(x^6\)." %}

{% capture content %}
This section is part of the capture tag that we will use as the content variable of 
the include with a block instead of using the content tag.
<br><br>
This is a simple mathematical definition.  We are going to see what happens when we 
extend the definition of a mathematical statement.  Will this text be wrapped 
properly around the area that is being used? \(x^6\).
{% endcapture %}

{% include definition.html content=content %}

{% assign content = 'Hello, world!' %}

{% include definition.html content=content %}

{% capture deftwo %}
This section is part of the includex tag that we will use to mimic the include with
a block instead of using the content tag.
<br><br>
This is a simple mathematical definition.  We are going to see what happens when we extend the definition of a mathematical statement.  Will this text be wrapped properly around the area that is being used? \(x^6\).
{% endcapture %}
{% include definition.html content=deftwo %}

Let us add some text here to see what happens.

{% include theorem.html content="This is a simple mathematical theorem. It is used to determine if the include works correctly." %}

What about adding some here.

{% include theorem.html content="This is another simple mathematical theorem. It is used to determine if the include works correctly.  This one will contain a proof." proof="This is the proof of the theorem mentioned here.  Let us see if this works as expected." %}

```html
<script type="text/javascript" id="MathJax-script" async
  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
</script>
```

Write some Latex formula $$x_2$$ and $$x^3$$.

When $$a \ne 0$$, there are two solutions to $$ax^2 + bx + c = 0$$ and they are
$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$

{% include definition.html content="When \(a \ne 0\), there are two solutions to \(ax^2 + bx + c = 0\) and they are $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$

The following text should be displayed on its own line." %}

{% comment %}
The following will use the capitalize tag to capitalize each word.

{ assign str = 'This is a assigned string' }
{ assign value = 101 }

{ capitalize content="this is a simple list of words" data=foo quote='This is a simple quoted string' string=str value=value }
{% endcomment %}
