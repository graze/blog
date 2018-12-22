---
title: "networked services"
date: 2013-08-23T10:00:00.000Z
author: andrew-lawson
---

## Services over a physical or virtual network interface

We discussed in a [previous post](/2013/07/01/service-oriented-communication) about our ongoing efforts to move some core systems out into their own services. This will help us scale our more memory and CPU intensive processes as we need, but relying on remote systems doesn't come without its own problems. The most vulnerable part of networked architecture is the network itself. As software engineers, we should build our systems in a way that can deal with any problems that can arise during runtime. This is usually done by simply throwing exceptions or passing errors through callbacks, but when you're working with critical systems, this is not always the answer.

In this post, I'll be discussing the different ways to tackle network failures and timeouts with long running critical processes over HTTP.

## Our pseudo application

To better understand the context of this discussion, it might be useful to have an example application to work with. Imagine we have a remote (albeit rather contrived) service that takes an array of product IDs and returns the stock count and the location of each. Lets also imagine that this process can take from 5 seconds up to 300 seconds to complete. A typical workflow over HTTP would look something like this:

![Basic HTTP](/content/images/2014/Apr/basic.gif)

There are a couple of problems with this implementation. Firstly the connection is likely to timeout, either on the client or the remote service. Secondly the connection could be severed completely giving the client no possible way to get the results of the request it made without sending a new request when the connection comes back up.

## WebSockets

WebSockets could be used to establish a long living connection to the remote service. This most certainly works around the timeout issues from the workflow above, but will hit the same problems with a severed connection. If the connection is severed, however, the remote service is made aware that the client has disconnected and the process could be cancelled. While we stop needlessly processing data, the request will need to be repeated by the client when the connection can be reestablished.

## Callbacks

Callbacks are the bread and butter of asynchronous programming. It's a pretty clear cut way of saying "Do *this*; when you're finished, give the results to *that*". This can also be used for service calls over HTTP. You just have to specify a callback URI in the request.

![Callback](/content/images/2014/Apr/callback.gif)

We seem to have worked around both network issues. The initial request should take mere milliseconds to return and the remote server has guaranteed the results will be delivered back to the client. The server may have to keep attempting to invoke the callback URI if the network is down, but this should be a simple case of implementing a queue of callbacks.

This approach makes two rather large assumptions, though. Firstly the client must have an HTTP server to retrieve results through. Secondly the client must also be able to handle the results completely asynchronously of the request. If these two situations don't impose any side effects to your client system, this might be a perfect solution.

## Polling

With the buzz around WebSockets and the changing state of technology, polling seems to have garnered a rather bad name for itself despite still being very relevant<sup><a href="#footnote-1">1</a></sup>. Again, by using this approach the initial request should take mere milliseconds. The remote service should respond immediately with a unique request ID after queueing the job. The client can then poll the remote service with the ID until a result is available.

![Polling](/content/images/2014/Apr/polling.gif)

We can also avoid losing data from broken network connections by resuming polling once the connection is reestablished. This solution works very well for all types of clients. It doesn't assume the client is an HTTP server and it doesn't assume the client can handle the results asynchronously.

## To summarise

The biggest vulnerability to networked architecture is the network itself, but there are proven ways to effectively manage it with well structured services. Your services may be fast enough to make dropped connections a non-issue, in which case a simple request-response approach would be perfect, but given growing business needs and complexities, data processing services will always need time to render a response.

We hope this post has answered questions you may have had and also sparked some new ideas for your next project.

---

- Both Twitter and Facebook use polling to implement their "live streaming" pages.

---

