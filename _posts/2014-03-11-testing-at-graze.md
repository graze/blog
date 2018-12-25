---
title: "Testing at graze"
date: 2014-03-11T11:39:00.000Z
author: will-pillar
tags: [ development, pull-requests, testing, unit-testing, phpunit, functional-testing, behat, ci ]
---

Inspired by AirBnB's [Testing at AirBnB](http://nerds.airbnb.com/testing-at-airbnb) article, I thought I would share some of what we do at graze to test our code before it makes it into production and what we're moving towards.

At graze we are currently entering into a period of time where testing is becoming ever more important with a growing team and international business. This has caused us to review our approach to testing and introduce new ways and processes for managing our code to decrease the likelihood of new code breaking in production.

## Pull Requests ##

As with AirBnB, a few months ago we introduced a new requirement for all significant chunks of new code. They have to be submitted through a Pull Request on GitHub. This has many many advantages to the alternative of allowing everyone to push into our shared branches:

- Enforces developers to be more accountable for the code they write.
- Ensures that code is reviewed by peers to improve quality and catch mistakes.
- Allows us to run some tests using a CI server on the Pull Request before a merge.
- GitHub's interface for Pull Requests serves as an excellent platform for annotating and discussing individual lines of code.

The only current requirement is that the Pull Request is reviewed by at least one member of your team who personally does the merge. This has led to having quite a few Pull Requests open at once and requiring review which comes with some challenges but if it's managed properly and you get developers to pester for a merge then it's worth the effort to take time out to review Pull Requests.

## Unit Testing ##

The majority of our applications are written in PHP and for unit testing our code we use [PHPUnit](http://phpunit.de/) which has become the defacto standard unit testing framework for PHP applications.

Historically we have had a test suite which has tests which touch databases, filesystems, caches etc. Unfortunately this means that as our test suite has grown so has the total run time for our test suite, sometimes peaking at 3 minutes for the full suite. It also means that some of our tests become unreliable as they are sensitive to data changing beyond their control and the minute a test becomes unreliable it sort of becomes irrelevant. This was obviously going to become a problem so we started looking at writing our tests to be more unit and less functional in an effort to reduce that time and increase the reliability of our suite.

In our new unit tests we use [Mockery](https://github.com/padraic/mockery) to mock or "fake" our class dependencies for the duration of a test in order to test individual functions rather than the whole dependency stack like an integration or functional test would. This means our new tests do not touch filesystem, database, cache or any other form of I/O, not only improving the reliability of our tests but drastically improving the performance of them.

We'd definitely recommend Mockery if you've not used it before, it has a much better API than PHPUnit's baked in mocking features and generally performs better.

## Functional Testing ##

Besides our legacy test suite we have been introducing functional test suites that are more geared up to test through the browser than the backend code. There are key areas of the frontend that any website needs to protect and ensure that they do not break:

- Signup
- Login
- Managing Orders
- Rating Products

If any of those website functions breaks in production then your customers will likely be having a bad time, as will you. It therefore makes total sense to test the functionality of those key areas as part of releasing/writing new code. For a long time we've done this manually, it has been the developer's responsibility to ensure that these areas are not broken which is fine until your team begins to grow and this becomes unmanageable.

What we needed was a way to write tests for the frontend of the website through a browser and automate this so we could integrate with our release process and eventually our CI server. Typically people will recommend [Selenium RC](http://docs.seleniumhq.org/projects/remote-control/) for this job, however it does not run headlessly and if we wanted to automate our functional testing during our release process and CI then a headless browser would need to be an absolute requirement.

What we landed upon was a combination of [PhantomJS](http://phantomjs.org/) and [Behat](http://behat.org/). PhantomJS is our headless browser and Behat is what we use to run the tests that we write using Behat's Gherkin syntax:

<?prettify?>
    Feature: auth_signin
        As a visitor
        I want to log into my existing account
        So I can continue using the service

    Background:
        Given I generate user

    Scenario Outline: Signin
        Given I am a visitor
        And I am on "/<locale>/auth/login"
        When  I fill in the following:
            | email    | {user.email} |
            | password | graze        |
        And I press "login"
        Then  I should be on "/<locale>/products"
        Examples:
            | locale |
            | uk     |
            | us     |

This is an example of a Behat test written in the Gherkin syntax. It's a behaviour driven way of writing tests and is a really nice way of writing a frontend test from the user's perspective, removing yourself from the code behind it all. This test makes sure that our customers can login to the website in both US and UK. We've just started rolling these tests out and now developers are using them and writing them to ensure frontend functionality is not broken by new code. Soon these tests will become part of our release process so that we can't release new code if these tests fail.

## Continuous Integration (CI) ##

This is something we've started introducing as recently as a couple of weeks ago, we're getting to a good place with the test suites we've got in terms of coverage and reliability, the next step is to start automating our testing. What we gain from having a CI server is our test suites being automatically run for new Pull Requests, new branches and new pushes to our master branch. This means we've got a much greater visibility over when something breaks and more testing of our code than developers would do manually.

At the moment we're using [Buildbox](http://buildbox.io) to manage our builds on our own CI server in the cloud. It's sitting there and building new Pull Requests and pushes to our master branch while we trial it. So far Buildbox is looking good, it allows us to run a build on our own server but defer the handling of GitHub integration and what to build and when to Buildbox's servers.

Eventually we want to fully automate our release process from a single push to the master branch we should be able to kick off a CI build which will run our tests, should they pass it will automatically stage the new code on one of our staging servers and then eventually push the code out to our live servers.

## The Future ##

What we've come to realise over the last few months is that all of these different test suites and processes have to work together in order to deliver a fully automated testing platform. Without a quick test suite our CI builds would take too long, without Pull Requests we couldn't have peer oversight and guidance, without complementary unit and functional test suites we couldn't be as confident with releasing new code and without CI we couldn't ship as quickly as we need to whilst ensuring our code is tested.

We're slowly but surely moving towards a fully automated testing and release platform and when we get there it will enable us to move fast, ship new code and let our services and processes work for us instead of us working for them.

Testing doesn't need to be something that kills your development speed or gets in your way, if you write testable code, make it easy to write tests and even easier to run the tests then you're already gaining so much more than you're putting in.

