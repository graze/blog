---
title: "AWS hack day with Rackspace"
date: 2017-03-06T09:43:25.000Z
---

We partner with Rackspace to manage our production infrastructure on AWS. We've been running regular hack days recently and thought it'd be good to take a day out of shipping code to work with Rackspace on a hack day to play with some of the new beta tools that AWS released in December.

The goal of the hack day was to become more familiar with working with AWS in the hope that we can use it more in our projects. We were primarily using AWS technologies [Polly](https://aws.amazon.com/polly), [Lex](https://aws.amazon.com/lex), [Rekognition](https://aws.amazon.com/rekognition), and [Athena](https://aws.amazon.com/athena), as well as supporting services such as [DynamoDB](https://aws.amazon.com/dynamodb), [Lambda](https://aws.amazon.com/lambda), and [S3](https://aws.amazon.com/s3), and the results were astounding. In seven hours, we saw teams complete five projects. Here's a summary of the day:

<iframe width="600" height="337" src="https://www.youtube.com/embed/4r8cv9-RJrg" frameborder="0" allowfullscreen></iframe>

Teams created a variety of different solutions to existing graze problems, including:

* A customer services question and response solution via Facebook messenger, using Lex to process human input and appropriate responses offered to help customers with snack recommendations and also for help with their graze account. The conversation went on to the point where Lex could send the collected data to a Lambda function, which allowed us to take action on the customer's account if necessary.
* An automatic sign-in system for the office using Rekognition to do face detection and Polly to confirm the successful sign in or out. It could be extended to add additional information, such as let the employee know when their first meeting was, or what the weather would be like on their journey home.
* An iOS app to offer snack recommendations from a photograph and from user voice input using Rekognition for image detection and Lex for audio recognition, and then using keywords from the image and voice analysis, to post to a Lambda function to return a snack from our range and offer it to the customer.


In addition to coding some amazing projects on some incredible technology, the graze and Rackspace teams also took time to experiment with VR technologies such as [Google Tilt](https://www.tiltbrush.com), and the [iCaros VR flight wing suit](http://www.icaros.net/index.php/pages/about-icaros) experience.

We continue to hold regular hack days for our team to encourage learning and keep up to date with technology, and generally to be always having a great time!