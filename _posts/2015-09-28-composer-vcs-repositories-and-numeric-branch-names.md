---
title: "composer, alternative repositories and numeric branch names"
date: 2015-09-28T15:01:06.000Z
author: john-smith
tags: [ php, composer ]
---

Sometimes with composer you'll want to point to a repository other than [packagist](https://packagist.org). At graze, a common use of this is to include a private project in an application.

Composer facilitates this through the "repositories" directive -

```YAML
"repositories": [
    {
        "type": "vcs",
        "url": "https://github.com/graze/top-secret-private-package.git"
    }
]
```

Including `top-secret-private-package` at tagged version `1.1.2` in our app is then the same as usual -

```
"require": {
    "graze/top-secret-private-package": "1.1.2"
}
```

If we're developing a new feature for `top-secret-private-package` on the branch `cool-new-feature`, rather than creating a new tag, we can ask composer to fetch directly from that branch -

```
"require": {
    "graze/top-secret-private-package": "dev-cool-new-feature"
}
```

Notice branches are prefixed with `dev-`.

This is slightly different for numeric branch names - these are suffixed with `.x-dev`. If we want composer to fetch branch `0.1.1` of `top-secret-private-package`, it would look like this -

```
"require": {
    "graze/top-secret-private-package": "0.1.1.x-dev"
}
```

`composer show` is your friend here. It will help to verify everything's set up correctly and list all available versions -

```
$ composer show graze/top-secret-private-package

name     : graze/top-secret-private-package
descrip. : Really excellent package that does secret things
keywords : excellent, secret, things
versions : dev-master, 0.1.1.x-dev, 1.12, dev-cool-new-feature
...
```

To read more about versions, check the [composer docs](https://getcomposer.org/doc/02-libraries.md#specifying-the-version).

#tl;dr; numeric branch names require the suffix `.x-dev`

