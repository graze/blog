---
title: "Why we migrated from Magento 2 to Shopify Plus"
author: james-weaver
image:
  src: /content/images/2019/graze-x-shopify.png
  alt: graze logo and shopify logo
tags: [ shopify, shopify-plus, magento, web ]
---

In January 2019 we completed the migration of our [UK shop](https://uk.graze.com) and [US shop](https://us.graze.com) from [Magento 2 Enterprise](https://magento.com/products/magento-commerce) to [Shopify Plus](https://www.shopify.co.uk/plus).

The decision to migrate away from Magento was significant for us. We have been Magento users since launching our [beta graze shop](https://www.marketingweek.com/2015/11/19/graze-opens-up-to-non-subscribers-in-ecommerce-push-%E2%80%A8/) in late 2015. We invested heavily into our Magento shops, creating a seamless customer experience with our [subscription site](https://www.graze.com), and building the graze rewards scheme that rewarded customers for reaching certain subscription and shopping milestones.

### Why did we consider migrating away from our [award winning](https://inviqa.com/blog/inviqa-recognised-magento-pioneering-graze-website) Magento shops?


- **Upgrades** - As a small team we found Magento upgrades to be incredibly disruptive. It was not uncommon for security fixes to be included with backward-incompatible changes. Upgrades could consume entire sprints, causing real disruption to our roadmap.

- **Costs** - Our running costs were disproportionately high compared to those of our subscription site. These costs included the Magento 2 Enterprise Edition License Fee, specialist Magento cloud hosting, Magento Certified Developers, as well as the graze web services that we built to support the experience.

- **Scaling** - We made heavy use of Magento 2's customer segmentation to power many of our shop features, including the graze rewards scheme. Due to our large customer base, changes to segmentation logic (segmentation writes) or sudden spikes in traffic (segmentation reads) could lead to severe performance degradation (before auto-scaling had time to kick in). This required ongoing management, email campaigns and sales would need to be carefully coordinated to ensure our Magento servers had scaled up before the load hit, and segmentation changes would typically be done very early in the morning.

- **Performance** - We were never satisfied with the performance of our Magento shops, particularly on slower 3g/4g connections. We had two audits conducted by specialist Magento Agencies to identify performance improvements but we were only able to make incremental gains.

- **Extension Ecosystem** - One of the selling points of Magento is its [extension marketplace](https://marketplace.magento.com/). We found the quality and support of extensions varied dramatically. We also found extensions did not always interact well with each other, often in frustratingly obscure ways.
Testing (and sometimes patching) extensions were another thing to manage when performing Magento upgrades.

- **Onboarding Experience** - As the complexity of our site grew, so  did the time it took to onboard new developers and Magento users (e.g. Customer Services, CRM).

### Shopify


[Shopify](https://www.shopify.co.uk) is a managed ecommerce platform with some 800,000 customers. The standard Shopify offering lacked some key features for us, most critically the ability to use accounts mastered on our graze subscription site. [Shopify Plus](https://www.shopify.co.uk/plus) is aimed at enterprise customers and offers the ease and simplicity of Shopify but with tools and features for enterprise customers.
On paper, Shopify Plus seemed to be a good fit, particularly when we compared it to some of the sticking points we were having with Magento:

- **Upgrades** - Platform upgrades would be managed by Shopify, freeing up developer time.

- **Costs** - Based on our initial estimates Shopify presented considerable cost savings.

- **Scaling** - Taken care of entirely by Shopify, freeing up our CRM and Product teams to work to their own timelines.

- **Performance** - When looking at some of the more complex Shopify Plus stores, we found them to be significantly more performant than our Magento shops.

- **Onboarding Experience** - The API documentation was clear and sensible, the admin interface seemed modern and easy to use.

- **Extension Ecosystem** - Shopify has a vibrant App Store with lots of big names in there, not unlike the Magento Marketplace. But unlike Magento, these apps would be hosted and managed for us, freeing us from maintaing them.

### How we decided to move to Shopify Plus

To evaluate whether we could and should move to Shopify Plus we wanted to build as much of a working prototype as possible. We contacted Shopify and were put in touch with a London-based account manager as well as a solutions engineer. We were given access to a trial Shopify Plus store, so we set aside a few weeks to bring together some of our Data, Digital Product, Web and Operations team members, to help us better understand Shopify Plus and its capabilities.

Some of the key areas we covered:

- **Stock and Order Management** - We built a prototype integration with our stock and dispatching systems to test the API and understand how much integration work would be needed.

- **Front End Capabilities** - We built a basic graze theme using the shopify [starter theme](https://github.com/Shopify/starter-theme) and [bulma](https://bulma.io/) using the Shopify [slate tooling](https://github.com/Shopify/slate).

- **App Development** - We built a Shopify App in node.js that allowed customers to set and retrieve some food preferences, it also allowed admins to view these preferences within Shopify.

- **Sign On** - We took a look into [Shopify Multipass](https://help.shopify.com/en/api/reference/plus/multipass) to see how we could use graze.com accounts with Shopify Plus.

- **Product Management** - We looked at how we could integrate with our existing product catalogue, we also researched PIM options as a possible solution for merchandisers.

- **Data** - We looked into what analytics Shopify made available and how we could import it into our data warehouse).

- **App Marketplace** - We tested a bunch of Shopify Apps to understand what features we could add without needing to build them ourselves.

- **Rewards** - We met with a number of loyalty programme app providers, we also looked at how we might build our own rewards programme.

- **Shopify as a CMS** - we built some example  [homepage sections](https://help.shopify.com/en/themes/development/sections) and tested out this [approach from oak.works](https://oak.works/blog/technical/2017/03/23/shopify-sections-editor/) to use sections on pages other than the homepage. We also tested some of the popular 'page builder' apps.

### Findings

We compiled our findings into a high-level document to share with various stakeholders at graze. These are some of the key findings:

- **Apps** - Shopify Apps are easy to install, some are just one click, and most paid apps offer a trial period. This would open an exciting path for our Digital Product team to rapidly test new site features and gain valuable learning before committing to development. We were able to test a wide range of apps and identified several that would immediately save development time:
  - Shopify Reviews - comments and star ratings on products
  - Zendesk - for integration with our Zendesk helpdesk
  - PixelPop - for site-wide modal messaging
  - Instafeed - for embedding an instagram feed

- **CMS** - Apart from the homepage, we found CMS is quite limited unless you want use one of the page builder apps or the [section hack](https://oak.works/blog/technical/2017/03/23/shopify-sections-editor/). We didn't expect to be building many custom pages on Shopify, so this was not a blocker.

- **Costs** - Our initial cost estimates had not factored in that we would be running multiple Shopify stores, increasing the cost of some of the paid-for apps that we were looking at. Despite this, we were still looking at substantial savings.

- **Documentation** - Shopify API documentation is well maintained, and kept up to date. The Shopify forums however contain lots of outdated posts from many years ago (5+ years) that contain out of date information, making it hard to find

- **Payment Gateways** - There are lots of payment gateway options available, including our existing payment providers (Adyen and Paypal). We also have the option of using [Shopify Payments](https://help.shopify.com/en/manual/payments/shopify-payments)
 makes other payment method integrations (e.g. Amazon Pay, Apple Pay, Google Pay) available without any development work.

- **Product Management** - Shopify Product management is straightforward, with a sensible API and intuitive naming. However, when looking at ways to store the legally required nutritional data against a product (allergens, nutritional information, ingredients), our options were limited:
  - As part of the description - poor for managing, and editable by any merchandiser
  - As images - poor for accessibility and again, editable by any merchandiser
  - As [metafields](https://help.shopify.com/en/manual/products/metafields) - this was our only real option, metafields would allow us to store JSON however we encountered issues with character limits

If we wanted to use Shopify we would need to find a different solution to managing product nutritional information.

- **Single Sign On** - Single sign on would be possible using multipass and we still be able to master accounts on our subscription website. This would make things considerably less risky, as we would not need to migrate any customer data, part of the reason we could even consider this move is because we had chosen not to master customer data in Magento.

- **Theme Development** - Tools such as Shopify Slate make theme development pretty straightforward and provide a starter theme to get started quickly. There is also scope to build and host a custom frontend using the [storefront API](https://help.shopify.com/en/api/custom-storefronts/storefront-api) via graphQL.

- **Customer Experience** - The overall browsing and buying experience was superior to our Magento site. But there were some drawbacks, most notably customers would no longer be able to use their subscription payment cards and would not have the same integration with their address book.

### Findings - Summary

As I mentioned previously we had invested much into our Magento 2 platform, so we would need some compelling reasons to justify the risk of migrating. But as you can see from our findings there were lots of positives to be found, and few drawbacks.

Through our prototyping and research, we felt confident that integrating Shopify would be relatively straightforward, and that we would be able to offer customers most of the functionality we already had in place (either like-for-like or through alternatives).
Our biggest concern was around the additional friction for subscription customers when checking out. However, we believed the vastly improved shopping experience would help to offset this, particularly on mobile devices that represent the majority of our traffic. We also felt confident in the tools that would be at our disposal to mitigate against drops in commercial performance; whether it be through apps, changes to CRM activity, UX/UI changes, or by introducing faster payment methods (e.g. Apply Pay, Google Pay).

### What's next

This is the first post in a series covering graze's migration to Shopify Plus. Futures posts will cover:

- how we migrated to Shopify Plus (spoilers: it went really well, and happened surprisingly quickly!) and what we learned along the way
- how we built our new rewards scheme on Shopify Plus
- how we manage CI/CD across multiple Shopify Plus stores
- how and why we used Shopify to launch an MVP Europe subscription platform
