Grazeâ€™s Web team has grown enormously over the last three years. As front-end teams become larger, the need for a pattern library becomes increasingly clearer. We realise that now, but our initial plan was somewhat different.

In June 2015 we believed that the solution to our design woes was a web style guide; A document that would help developers and key stakeholders throughout the business understand *how* and *why* we use certain UI elements across the website. We started by auditing the website; looking for style patterns and uncover any inconsistencies. It didnâ€™t take too long to establish that there was little consistency across our website and this was down to the fact that our development environment and processes did very little to encourage it.

![Order a recurring box screen](/content/images/2016/04/graze-com-order-recurring-box.jpg)<small>Order a recurring box screen</small>

As an example, the above screenshot has 9 different styles (font, size, weight), even when you exclude the colours.

Graze.com had only just gone through a major overhaul 18 months earlier to Bootstrap with custom overrides; lots of them. An already bloated  framework had become even more bloated and sticky plasters were littered all over it. It was time to start again, but this time start from scratch.

So, what began as a project to create a style guide, quickly grew to become building a custom framework and pattern library that both use a single codebase. Meaning that when you make a design change decision, you only have to make the change in a single place.

![Atomic Design](/content/images/2016/04/atomic-design.png)<small>Brad Frost's Atomic Design</small>

Using Brad Frostâ€™s Atomic Design methodology and taking inspiration from Lonely Planet and MailChimp, we put together a list of essential UI components and modules, or atoms and molecules, that we would need to include. This list included typography, form inputs, buttons, list styles etc. One thing that we did decide to keep from our old framework was the Bootstrap grid.

---

Pistachio will help the entire design process, from prototyping through to delivery of a final product. It means that we can design in the browser by simply importing the CSS file from the CDN. This code can also be used by the front-end developers giving them a head-start in production.

The Design Guild now has a weekly meeting and itâ€™s here that we have the opportunity to review Pistachio and discuss what should be updated, removed or added. There should no longer be a debate during a project about what colour a button should be, or what it should look like. By doing this it means projects can run smoother but also that our pattern library is constantly updated to meet our needs and uses modern web technologies and design trends. Anyone from across the business has an opportunity to give feedback about Pistachio and the Design Guild will discuss and debate anything raised.

##Whatâ€™s next?

As part of Atomic Design itâ€™s important to create example templates - and thatâ€™s what we are going to be adding more of to Pistachio.