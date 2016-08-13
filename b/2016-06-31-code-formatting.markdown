---
title: Code formatting
author: Krišjānis Veinbahs
---

The blog seems to be coming together quite nicely, but while coding some arbitrary responsiveness CSS I suddenly realized that I'm creating a code showcase blog... without any actual way to show my code!

I started off by searching some programming fonts and thinking about how am I going to style div's and how will markdown know that I'll be presenting code. But then it clicked.. No way am I the first with this problem, someone else has for sure had this already.

And I was right, because this is the internet. If you can think of something, then somebody has probably done it (unfortunately this rule also applies to a lot of weird stuff you'd rather didn't exist, but that's for a different post). And behold of the code formatter I now possess - [Highlight.js](https://highlightjs.org/). See it in action with some example code from an old version of [Orbitals](https://github.com/kshaa/orbitals):

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
