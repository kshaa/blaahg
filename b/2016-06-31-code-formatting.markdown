---
title: Code formatting test
author: Krišjānis Veinbahs
---

The blog seems to be coming together quite nicely. While coding
some arbitrary responsiveness CSS I suddenly realized that I'm
creating a programming blog, but I don't even have a decent
way to present any code.

I started by searching some programming fonts and thinking about
how am I going to style div's and how will markdown know that
I'm presenting code. But then it clicked.. Someone else has most
for sure had this problem already.

And lo' and behold, I now have a code formatter -
[Highlight.js](https://highlightjs.org/), example code from an
old version of the [Orbitals](https://github.com/kshaa/orbitals)
project:

```
orbPointForce: function (settings, point, mass) {
    var gravity = settings.gravity;
    var m1 = this.mass, p1 = this.position;
    var m2 = mass,      p2 = point;

    var radius = p1.sub(p2).length();
    var force = (m1 * m2 * gravity) / (radius * radius);
    this.force = p1.clone().setLength(force).negate();
}
```
