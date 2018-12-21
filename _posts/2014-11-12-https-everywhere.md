As a pioneering online business, we need to lead the way in terms of ensuring our user's privacy and protecting their data.

We enabled encryption for all traffic to the [graze.com](https://graze.com) domain back in July. With this update we also turned on the [`Secure` and `HttpOnly` flags][1] for our authentication cookies, and will be doing the same for the rest in the near future.

![SSL Enabled](https://d29heo999a0e0g.cloudfront.net/c6b4e3a5b09e9518f1c8a0efe59d56ce.png)

Adding a [HSTS policy][2] header to our responses and including the graze.com domain on the [HTTP Strict Transport Security preload list][3] are just a few security improvments that we'd like to do, leading neatly on from rolling out 100% SSL.

These changes would make sure that our customers make as few requests as possible to the graze website over an insecure connection (such as the first visit made by a customer from an old non-SSL link).

*Edit* â€“ For some further reading, The New York Times published a great post on [why we should embrace HTTPS][4].

> by [Sam Parkinson](https://github.com/sjparkinson)

[1]: https://en.wikipedia.org/wiki/HTTP_cookie#Secure_and_HttpOnly
[2]: https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security
[3]: http://www.chromium.org/sts
[4]: http://open.blogs.nytimes.com/2014/11/13/embracing-https/