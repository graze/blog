---
title: "The graze css framework"
date: 2014-03-21T11:40:00.000Z
author: lee-jordan
image: /content/images/2014/Apr/graze-css.jpg
tags: [ css, bootstrap ]
---

In the graze web team we pride ourselves on being able to rapidly develop new features in response to our customer and business needs but that rapid pace of development has sometimes come with a bit of associated baggage.

Graze used to have a separate mobile site that over time began to feel neglected and lack some of the features of the main site which just wasn't good enough for us because our proportion of mobile users is very high and will only increase. There was also a concern about the consistency of the graze user experience because we were often creating components in isolation with a bespoke design each time. This led to an inefficient use of CSS, bloated CSS libraries and an inconsistent user experience. We also began to move towards a responsive website and retro-fitting responsiveness onto our existing site became problematic.

![example of a page built in the graze css framework](/content/images/2014/Apr/graze-css.jpg)

## The importance of responsive web sites

There are many benefits to having a responsive website but perhaps the main tech problem it solves is that the developer can have a reasonable sense of security that their site will work in almost any size of browser, even on mobile devices. There are many benefits to the customer and the business too as proved in a [2012 survey by google](http://googlemobileads.blogspot.co.uk/2012/09/mobile-friendly-sites-turn-visitors.html) where 67% of people surveyed said they were more likely to buy from a mobile-friendly site.

One important thing to note here is that responsiveness is not a panacea and you should still create device specific web pages where appropriate to take advantage of the features available on those devices.

## The importance of consistent design

Consistent design across the graze site is important in the aesthetic sense because a consistent, coherent website simply looks more professional. Leftover pages from previous website versions look outdated and out of place, and may lead the visitor to believe that the information there is incorrect or out of date. It is also important for the graze site to behave consistently so that it is easier for our users to understand how to interact with the site through the sharing of common components and behaviours.

## Bootstrap

We decided to build our graze CSS framework using [bootstrap](http://getbootstrap.com/) firstly because it is built with [.less](http://lesscss.org/) which is a very useful css pre-processor that allows us to write CSS in a more maintainable and extendable way. In addition to this bootstrap is a widely used open source framework with an established userbase and an active community.

First we take only the bootstrap .less files that we actually need and then we override and extend those CSS declarations as required, making extensive use of .less mixins and helper classes. In this way, we can easily update our core bootstrap files to the latest version without affecting any of our bespoke graze declarations.

At its core bootstrap has a very flexible grid structure that makes it really easy to build responsive web pages, speeding up our development process further while also ensuring an aesthetically and behaviourally consistent website. It also includes several useful javascript components that we have made extensive use of.

## The future

Several new features on our website have been built using this framework so far and it is our goal to convert or rebuild all of our pages in this framework in the coming months. This will futureproof our site by giving our front-end developers a solid responsive framework on which to build.

