---
layout: root
title: Simple Index File
css:
    - /assets/css/main.css
    - /assets/css/foo.css
    - /assets/css/bar.css
js:
    - /assets/js/main.js
    - /assets/js/foo.js
    - /assets/js/bar.js
---

# Introduction

This is a simple html file.

|Table|
| :--: |
| This is an entry |
| This is another entry |

{% element p %}
This is a simple paragraph that is used to define the given paragraph using the element tag.  Why is this not working!!!!
Updated the element tag.
{% endelement -%}

<a href="https://www.google.com/search?q={{ 'foo and me' | url_encode }}" {% class foo-class %} {% id google-id %}>Google LLC</a>

{% element a href="https://www.google.com" %}
Google, LLC
{% endelement %}

{% element p %}
Note: {{ site.data.site.config.note | default: site.note | default: 'note is not defined' }}
{% endelement %}
