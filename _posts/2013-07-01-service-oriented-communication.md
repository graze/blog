##Handling service interoperability##
SOA (Service Oriented Architecture) is a widely implemented software design pattern, whereby certain areas of a system are separated off into services. It offers many benefits that include the freedom to use the right technologies for the
job, security through isolation, true separation of concerns, and the ability to easily [scale horizontally][blog-scaling]. There are [plenty][soa-1] [of][soa-2] [articles][soa-3] about SOA as a concept, but choosing exactly how your services communicate with one another is an oft-neglected topic.


## Choosing your transport ##
Diving straight into your service design, you will likely consider sending your data across HTTP. For the majority of services, HTTP would be a perfect choice. After all it's very easy to implement, you can test it in any language or web browser, and everyone will be familiar with how it works.

If you're not sure if HTTP is for you, take a step back and look at the other services we use every day; *email*, *instant messaging*, *3G*, and many more. With a large number of services, there comes a large number of protocols already designed for use. Some are proprietary for securing intellectual property and data across public networks, but there remains a growing number of publically available and documented protocols such as [WebSocket][wiki-ws], [BitTorrent][wiki-bittorrent], and [XMPP][wiki-xmpp].

The transport you use depends entirely on your service and the team building it. **Services does not necessarily mean webservices**.


## Semantic messages ##
If you've decided to use a transport that defines the exact semantics used to send specific messages (such as SMTP or BitTorrent) you can skip this section. Assuming you're going ahead with HTTP, there are a number of different ways to
send a message. You can [POST][wiki-http-methods] or [PUT][wiki-http-methods], send [XML][wiki-xml] or [JSON][wiki-json], use [SOAP][wiki-soap] or [RPC][wiki-rpc]. The choices are endless! Thankfully, there are a lot of specifications and libraries already defined for you.


### RESTful design ###
[REST][apigee-rest] is used throughout the web as the predominant interface to web services. Being so widely used means it is fairly often misused. Put simply, it is designed to use HTTP to define the intention of a message, whether it GETs a resource, POSTs a new resource or DELETEs an old one. It is perfectly suited to services that serve object (or
resource) mutability, but the semantics of it fall down when your service is a data processor rather than a data provider.


### RPC ###
RPC (Remote Procedure Call) is a concept allowing services to send and receive requests for both resources and processes. Its practical implementations exist as [XML-RPC][wiki-xmlrpc] and [JSON-RPC][wiki-jsonrpc], and although their exact specifications differ, the concept remains the same. Send an encoded message (often via HTTP) detailing the remote method and the data to process.

<?prettify?>
    {
        "jsonrpc": "2.0",
        "method": "subtract",
        "params": [42, 23],
        "id": 1
    }

The `"id"` serves only to identify the response from the server. The server should respond with similarly structured data.

<?prettify?>
    {
        "jsonrpc": "2.0",
        "result": 19,
        "id": 1
    }

## In practice ##
Here at Graze we're contiunously building out our systems and infrastructure to support the needs of our business, and separating systems into services has helped us achieve the scalability we need on some of our systems. In some of our newer services, JSON-RPC has given us the flexibility we need to send many different types of messages, be it getting or modifying a resource, running both synchronous or asynchronous processes, or running a batch of messages in a single request.

To that end, we created a little client to assist some of our PHP services. [Guzzle-JSONRPC][github-guzzle-jsonrpc] makes use of the [Guzzle][github-guzzle] HTTP client and adds a lightweight API for sending messages to your [JSON-RPC 2.0][spec-jsonrpc] server.

<?prettify?>
    <?php
    use Graze\Guzzle\JsonRpc\JsonRpcClient;

    // Single request
    $request  = $client->request('subtract', 1, array(42, 23));
    $response = $request->send()
    $result   = $response->getResult(); // 19

    // Batch of requests
    $request  = $client->batch(array(
        $client->request('subtract', 2, array(42, 23)),
        $client->request('multiply', 3, array(42, 23)),
    ));
    $response = $request->send();
    $subtract = $response[0]->getResult(); // 19
    $multiply = $response[1]->getResult(); // 966


Provided that the server accepts the request and returns a properly formatted response, communication between the
services is as simple as that.


## Stepping into SOA ##
There are a huge number of protcols and transport layers that could be used to provide SOA communication, far more than can be detailed in a single article. My advice is to spend some time researching your options and defining the use cases of your service. Just remember that although the communication of your service is important, it isn't as crucial as the service itself.

Hopefully this short post has answered some of the questions you might have had about operating between services so you can continue your research. If you have any questions, comments or views about SOA and the communication between services, please feel free to engage with us in the discussion section below.

We'd love to hear how SOA has helped your systems, too!


[blog-scaling]: http://blakesmith.me/2012/12/08/understanding-horizontal-and-vertical-scaling.html
[wiki-ws]: https://en.wikipedia.org/wiki/WebSocket
[wiki-bittorrent]: https://en.wikipedia.org/wiki/BitTorrent
[wiki-xmpp]: https://en.wikipedia.org/wiki/XMPP
[wiki-http-methods]: http://en.wikipedia.org/wiki/HTTP#Request_methods
[wiki-xml]: https://en.wikipedia.org/wiki/XML
[wiki-json]: https://en.wikipedia.org/wiki/JSON
[wiki-soap]: https://en.wikipedia.org/wiki/SOAP
[wiki-rpc]: https://en.wikipedia.org/wiki/Remote_procedure_call
[wiki-xmlrpc]: https://en.wikipedia.org/wiki/XML-RPC
[wiki-jsonrpc]: https://en.wikipedia.org/wiki/JSON-RPC
[apigee-rest]: https://blog.apigee.com/taglist/restful
[github-guzzle-jsonrpc]: https://github.com/graze/guzzle-jsonrpc
[github-guzzle]: https://github.com/guzzle/guzzle
[spec-jsonrpc]: http://www.jsonrpc.org/specification
[soa-1]: http://devblog.songkick.com/2012/07/27/service-oriented-songkick/
[soa-2]: http://architects.dzone.com/articles/enterprise-benefits-service
[soa-3]: http://programming.oreilly.com/2013/06/application-resilience-in-a-service-oriented-architecture.html

> by [Andrew Lawson](https://github.com/adlawson)