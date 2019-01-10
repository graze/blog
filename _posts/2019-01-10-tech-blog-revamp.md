---
title: "Tech blog revamp"
author: burhan-ali
image:
  src: /content/images/2019/blog-revamp-2019.png
  alt: "Screenshot of blog index page"
tags: [ blog, meta, github-pages, jekyll, open-source ]
---

The graze tech blog has been around since [the middle of 2013](/2013/05/13/welcome-to-snack-overflow.html) and has lived on a couple of different platforms in that time. It has moved again and is now hosted on [github pages](https://pages.github.com/) and is powered by [Jekyll](https://jekyllrb.com) and [Bulma](https://bulma.io).

![{{ page.image.alt}}]({{page.image.src}})

## Why?

Why did we make this move? Well, why not? ¯\\_(ツ)\_/¯

But actually, there were some more concrete reasons:

* It was a low impact method of learning about some new technologies that we had not used before.
* All developers have github accounts and so automatically have the ability to create blog posts. No need to have to maintain an account on another service.
* It fits in with our existing developer workflow of branch -> PR -> review -> merge.

The most important reason though was that it was fun! This was a nice little project to do towards the end of the year.

## How?

There were a number of things that needed doing to get this up and running.

* Convert the JSON data dump from the previous host into a set of post and author files.
* Clean up the content (eg. badly encoded characters, non-markdown markup, etc)
* Add support for a variety of other things:
  - Tags
  - Pagination
  - Post navigation
  - Social media preview metadata
  - Atom feed
* Set up DNS
* Run the output through the [W3C validator](https://validator.w3.org) to pick up any markup problems

Everything that has been done is visible in the [graze/blog](https://github.com/graze/blog) github repo.

The [Jekyll documentation](https://jekyllrb.com/docs/step-by-step/01-setup/) is extremely good and was very helpful in this project.

## Final thoughts

So what do you think about the new blog? Are there any features that you think are missing? Let us know via [github](https://github.com/graze/blog/issues/new) or [twitter](https://twitter.com/snack_overflow).

