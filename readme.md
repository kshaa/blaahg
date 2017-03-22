---
Krišjānis Veinbahs' blog
---

Blog / project showcase / info page.
Uses:
    1. Highlight.js for code snippet formatting
    2. NPM for managing projects in showcase
    3. Hakyll for easy site deployment / configuration

#### Deployment
* Fetch projects for showcase
```
npm install --legacy-bundling
```

* Compile, run hakyll code
```
stack build --silent
stack exec site (re)build --silent
```

* Blog's stored in \_site/
