---
title: "Pistachio - our new front end framework"
---

It's an exciting time for the graze web team as we're expanding into new territories such as a [dedicated support site](https://uk.help.graze.com/) and a [more traditional e-commerce site](https://uk.shop.graze.com/). Our [subscription site](https://www.graze.com) is also constantly being iterated and refined to improve the user experience.

We decided to dedicate some time to build a new front end framework and a web style guide to firm up some generally agreed upon but never properly documented front end web practices for use across all of our sites and to establish a baseline for all graze web sites going forwards.

Early on in its development somebody suggested the name "pistachio" and it ended up sticking. The original reasons for this choice of name are lost in the mists of time but everybody agrees it seems appropriate now.

Our old front end framework suffered from being tied up in a bit of a monolithic codebase which contained all backend and front end code. This meant it was hard to keep track of commits for the front end and as a consequence our CSS and JavaScript slowly became bloated. Pistachio however is entirely separate so it's much easier to have visibility over every commit. Perhaps the best way to illustrate this improvement is by comparing CSS specificity graphs. 

With CSS specificity graphs like this, spikes are bad news, and the general trend should be towards higher specificity later in the stylesheet.

Before Pistachio:
![](/content/images/2016/02/grazestrap-specificity.png)

After Pistachio:
![](/content/images/2016/02/pistachio-specificity.png)

We're now at the point that Pistachio is in use across two of our three sites with the last site about to undergo refactoring and we're happy to share it with the world so feel free to point your browsers at [pistachio.graze.com](http://pistachio.graze.com/) and get in touch if you have any feedback or opinions of any kind.

Here are some of the core principles we've decided to adhere to when building pistachio:

## Progressive enhancement

We believe in the principles of progressive enhancement for reasons of performance, reliability, and accessiblity. It's a widely discussed subject but here are the key points:

- basic content should be accessible to all web browsers
- basic functionality should be accessible to all web browsers
- sparse, semantic markup
- layout is provided by externally linked CSS
- enhanced behaviour is provided by unobtrusive, externally linked JavaScript

## CDN and Versioning

Pistachio is available on the CloudFront CDN, with CORS support enabled. We've also set up [versioned releases](https://github.com/graze/pistachio/releases) so we can use a known "safe" version of pistachio and only update to a different version when we're comfortable everything is working correctly.

## Sensible defaults

The intention here is that our front end framework should provide a solid baseline on which to iterate. It doesn't contain every possible front end web component you can imagine but provides a platform on which to build.

## Visual consistency

Every standard html element has a default style and our style guide provides opinionated directions on their appropriate use.

## Standardised components

Certain components we've identified as regularly being used across our sites have been standardised to ensure no matter which graze website a user visits, they should see and interact with roughly the same familiar functionality. Examples of this include dropdown menus, pagination, and forms.

## Modern front end practices

We're using flexbox in pistachio as well as advocating the use of html5 form attributes. Where possible, we're going to be taking advantage of emerging technology as long as it fits with our progressive enhancement approach.


## Benefits

The benefits of having a dedicated front end framework are many.

- As a standalone repo, we can carefully review all changes in isolation instead of having css or javascript changes bundled in with back end changes
- we can change the look and feel across all our websites at once by releasing a new version of pistachio
- we can concentrate on delivering the highest levels of performance and accessiblity on our front end by focusing our efforts in one place
- we have an established style guide with which to educate new members of the team and any third parties that we work with

> by [Lee Jordan](https://github.com/leejordan)