---
title: "Silex Routing and Trailing Slashes"
date: 2015-11-27T14:48:08.000Z
author: sam-parkinson
---

Silex treats a route like `/profile/1` as a different resource to `/profile/1/`, nothing wrong with that.

However, when using [controller providers](http://silex.sensiolabs.org/doc/providers.html#controller-providers), root level routes for that controller are mounted with a trailing slash, which leads to potentially undesired behaviour.

For example:

```php
class ProfileControllerProvider implements ControllerProviderInterface
{
    public function connect(Application $app)
    {
        $controllers = $app['controllers_factory'];

        $controllers->post('/', function () {
            return 'Foo';
        });

        return $controllers;
    }
}

$app->mount('/profile', new ProfileControllerProvider());
```

In this case `POST` requests to `/profile` will 404, as `/profile/` is the registered route.

**[@jrschumacher](https://github.com/jrschumacher)** posted a [handy meta-route to handle this](https://github.com/silexphp/Silex/issues/149#issuecomment-10384486), however unless you override the default url matcher, `GET` requests will continue to be handled in [`RedirectableUrlMatcher`](https://github.com/symfony/routing/blob/v2.7.7/Matcher/RedirectableUrlMatcher.php#L22-L44) and respond with a redirect.

I wrote a simple controller provider that iterates on @jrschumacher's work, defining the route and overriding the registered `url_matcher` correctly:

* <https://github.com/graze/silex-trailing-slash-handler>
