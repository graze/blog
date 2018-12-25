---
title: "Go at graze"
date: 2017-03-10T11:09:10.000Z
author: burhan-ali
tags: [ golang, microservices ]
---

<img src="https://camo.githubusercontent.com/98ed65187a84ecf897273d9fa18118ce45845057/68747470733a2f2f7261772e6769746875622e636f6d2f676f6c616e672d73616d706c65732f676f706865722d766563746f722f6d61737465722f676f706865722e706e67" width="200" align="right" alt="Golang mascot">

At graze we have historically been predominantly a user of the [LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) stack but on occasion we venture away from this and work with other technologies when we have a project which has specific requirements or we are in a position to experiment. [Go](https://golang.org/) is an example of one of those technologies. We have been using it in production on our primary systems for almost six months and in a few small housekeeping things prior to that. In this post we will talk a little bit about how and why we are using Go at graze.

## What are we using it for?

Over the last year we have been building a number of services to unify the two halves of the graze online experience  ([subscription](https://www.graze.com) and [shop](https://www.graze.com/shop)). While we are striving to produce microservices, a lot of them aren't true microservices at the moment because they don't do things like manage their own storage. One of the true microservices we have though is written in Go and uses [AWS DynamoDB](https://aws.amazon.com/dynamodb/) for storage. Other services in Go talk to our existing MySQL databases.

## Why are we using it?

Go is much faster than PHP and for  the microservices we were designing we needed fast response times. The fact that Go produced compiled native code rather than going through an interpreter like PHP was beneficial here. In practise we have an average response time in the single millisecond range. This is exactly the type of thing we were after as the service in question was something that would be called on every page request and used in conjunction with other API calls. Having a low response time means it has a smaller impact on the overall page response time.

Another reason was to have ad additional language in our toolbox. Most tasks can be accomplished in any general purpose language but some are better suited for specific purposes. Having languages that are different enough from each other gives you more flexibility in design decisions.

## Other things we have built

As part of using Go we have also produced a number of open source helper projects:

* [graze/golang-service](https://github.com/graze/golang-service) Logging handlers for go services
* [graze/docker-golang-tools](https://github.com/graze/docker-golang-tools) A docker container with additional tools we use
* [graze/cucumber-rest-bdd](https://github.com/graze/cucumber-rest-bdd) A behavioural testing suite for RESTful APIs. Not technically Go but was initially built for use with our Go services

We also have some internal tooling:

* A [Yeoman](http://yeoman.io/)-based generator for quickly getting up and running with a new Go service.
* A kit with all the building blocks we make use in Go services. eg. logging, authentication, common endpoints, etc.

No doubt there will be more things produced as our use of Go grows.

## The future

Using a different technology than our standard stack for standalone services is a really useful way of gauging if that technology is worth using more. It's not weighed down by any baggage or dependencies of existing code and so allows us to exercise our curiosity and be more experimental. In the past we have worked with Python for web services but didn't find it any better than PHP for what we wanted to do. We stopped using it for new services but still use it for some infrastructure tooling work (eg. [Troposphere](https://github.com/cloudtools/troposphere)). With Go we have found a language that complements PHP and is suitable for small services that require optimum performance with little overhead. As a result we now consider it to be one of our core languages.

We are continuing to try out new things with Go and have recently been evaluating the feasibility of using Go in conjunction with [AWS Lambda](https://aws.amazon.com/lambda/).

Look out for more Go-related content from us in the future.
