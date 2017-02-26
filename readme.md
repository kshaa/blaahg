---
Krišjānis Veinbahs' blog
---

A self-sustaining blog.
Shortest setup I could come up with.

#### Use
* Fetch p/ part of blog
```
npm install --legacy-bundling
```

* Compile the blog
```
stack build --silent
stack exec site (re)build --silent
```

Blog's saved in \_site/
