---
title: "You've got to have standards"
date: 2015-06-09T15:36:49.000Z
---

> Browsers are the most hostile software development environment imaginable.
> 
> -- <cite>[Douglas Crockford](http://en.wikipedia.org/wiki/Douglas_Crockford)</cite>

Front end web development can be painful. The pain is mostly caused by the almost infinite number of combinations of software and hardware. We don't have a locked down ecosystem like you have when building a device specific app using native language e.g. an iOS app. I'm here to remind you that this pain can be somewhat mitigated if you understand and follow web standards.


##What are web standards?

I'll let the organisation that writes and publishes web standards answer that one:

> W3C publishes documents that define Web technologies. These documents follow a process designed to promote consensus, fairness, public accountability, and quality. At the end of this process, W3C publishes Recommendations, which are considered Web standards.
> 
> -- <cite>[w3c.org FAQ](http://www.w3.org/standards/faq)</cite>

In essence web standards are a crowd-sourced set of rules that are written through a long process of discussion (with many passionate and long running arguments) until a consensus is reached. They are a set of democratic rules that all the various parts of the web industry make a great deal of effort to write and adhere to. Here are some examples from the current html5 specification which should be fairly widely known yet are still often forgotten or broken:

* When an a element that is a hyperlink, or a button element, has no text content but contains one or more images, **include text in the alt attribute(s) that together convey the purpose of the link or button**.
* The placeholder attribute represents a short hint (a word or short phrase) intended to aid the user with data entry when the control has no value. A hint could be a sample value or a brief description of the expected format. **The placeholder attribute should not be used as a replacement for a label**.
* **Do not use any method that hides the focus ring from keyboard users**, in particular do not use a CSS rule to override the 'outline' property. Removal of the focus ring leads to serious accessibility issues for users who navigate and interact with interactive content using the keyboard.

###Why are web standards important?
> Web standards are not arcane laws decreed by ivory-tower organizations. As we have described, the standards are for the most part decided by representatives of the same people who use them - browser makers, Web developers, content providers, and other organizations.
> 
> -- <cite>[webstandards.org FAQ](http://www.webstandards.org/learn/faq/)</cite>

Here's why web standards matter, and why following them will help you to build more reliable and accessible web sites:

* They dictate a common set of rules which web developers can (mostly) rely on to be present in all browsers.
* All browser developers make a great deal of effort to conform to web standards.
* Web standards help future-proof your web site as they are designed to be backward and forward compatible. Old versions of web standards are still supported even when new standards are published.
* They aid accessibility by ensuring your site is understandable by all browsers, even unconventional browsers and screen readers.

If you do not follow web standards, you shouldn't be surprised when some or all browsers do not render your page correctly. Early in my career I would often find myself trying to fix code that I had written that was not performing as I would expect it to and without exception this was because I was not following web standards. 

You can do some amazingly creative things in web development, but they should be extensions or enhancements on a solid foundation, and that solid foundation is precisely what is offered by web standards.

You've got to have standards.

> by [Lee Jordan](https://github.com/leejordan)