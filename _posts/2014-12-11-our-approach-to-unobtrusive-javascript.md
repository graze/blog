---
title: "Our approach to unobtrusive javascript"
---

> Unobtrusive JavaScript is a way of writing JavaScript so that if for any reason your JavaScript is not working correctly your web page should still perform its core function.

[![](/content/images/2014/12/unobtrusive-javascript.gif)](http://unobtrusify.com/)

There's nothing new about this concept and we certainly didn't invent it but the web team at graze has been working hard to make sure that JavaScript does not get in the way of our users' ability to interact with our site. In pursuit of that goal we always try to adhere to the following principles:

* Your feature should never rely on JavaScript being available.
* If JavaScript happens to be available, you can present your users with an extra layer of usability.

In practical terms and by way of example this means that:

* We build for core functionality first without JavaScript.
* All links must have a href.
* All forms must post to an endpoint that correctly handles the request.

##Why is unobtrusive JavaScript important?
We're not against JavaScript (in fact we love it) but we have to accept that it is the most unreliable part of the front end web stack. Unlike HTML and CSS where code that the browser does not understand is simply ignored, a broken line of JavaScript will break the script entirely. There's solid data behind this too. According to [a recent test performed by gov.uk](https://gds.blog.gov.uk/2013/10/21/how-many-people-are-missing-out-on-javascript-enhancement/), 1 in 93 (1.1%) of users failed to receive JavaScript enhancements for one reason or another.

By not relying on JavaScript we do not obstruct users from their goal if we can help it.

##How can JavaScript fail?

* Your JavaScript file is not downloaded fully (for example on a poor 3G connection).
* Your JavaScript file uses a method that the browser does not support.
* Your JavaScript file has a bug that only affects certain browsers.
* Your Javascript file has a bug.
* Your JavaScript file is blocked by a firewall.
* Your user's security settings prohibit the use of JavaScript.
* Your user has explicitly turned JavaScript off.

Hopefully this list illustrates that it's not just a question of buggy code. Obviously the onus is on us as a team of developers to have robust procedures and tests which reduce the amount of bugs we introduce but often the availability of JavaScript is out of our hands entirely.

![](/content/images/2014/12/error-1.png)

##Real world examples

There are lots of real world examples where not following the principles of unobtrusive JavaScript has caused real issues for huge numbers of people. For example, a large number of websites are broken in China because they use a JavaScript library delivered from Google's own CDN which is blocked by the ["Great Firewall of China"](http://en.wikipedia.org/wiki/Golden_Shield_Project).

Closer to home in the UK, the default network-level blocking by Internet Service Providers also blocks some domains regardless of content, so although graze might not (currently) care about our potential market in China, we do care about being reachable by a UK audience. It's unlikely to be a concern for us but it makes sense to prepare for any eventuality.

Sky broadband parental controls in the UK [recently blocked code.jquery.com](http://www.theguardian.com/technology/2014/jan/28/sky-broadband-blocks-jquery-web-critical-plugin) which is a commonly used CDN for the jQuery library. Lots of Sky broadband users had some or all JavaScript made unavailable to them.

In all of these examples, the impact of this could have been entirely mitigated by following the principles of unobtrusive JavaScript. There's no good reason why you should cause problems for your users by not following these principles which will ensure your site works without JavaScript.

##Conclusion
Even if we managed never to introduce a single bug into our JavaScript libraries, it's still possible that browser issues, security issues and connection issues outside our control will make JavaScript unavailable. Only by building our core functionality without JavaScript can we be sure that we do not obstruct our users' goals.

There's some extra value associated with our approach which is that we can quickly build a "minimum viable candidate", enabling rapid iteration of concept and user flows. We can then spend more time enhancing it with JavaScript once we have settled on something that works.

As always, let us know if you have any thoughts on our approach.

> by [Lee Jordan](https://github.com/leejordan)