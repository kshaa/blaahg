---
Krišjānis Veinbahs' blog
---

Official Krišjānis' blog for posts and projects.
As minimalistic as a blog should be.

#### Main dependencies
* [Stack](https://www.haskellstack.org/) for less hassle, when compiling site
* [Hakyll](https://jaspervdj.be/hakyll/) for building a static site
* [Bower](https://bower.io/) for fetching showcase projects

#### Use
* Fetch necessary extra dependencies
```
bower update --silent
```

* Build the site compiler (supposing you've got stack)
```
stack build --silent
```

* Compile the site itself
```
stack exec site build --silent
```

* Congrats, you now have a comiled version of my blog in hakyll-bio/_site
