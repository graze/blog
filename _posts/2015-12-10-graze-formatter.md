---
title: "graze formatter"
date: 2015-12-10T10:39:00.000Z
author: sam-parkinson
tags: [ open-source, php ]
---

Yesterday we open-sourced a new library, [graze/formatter](https://github.com/graze/formatter).

It's a pattern we've used extensively in our web application for more than a year now, and it's no coincidence that we started implementing it during our migration to the twig templating engine.

Previously we passed our legacy templating engine our active record objects directly. Views then had access to all the methods and properties defined on these classes, which meant that working out what data any particular view actually needed was not always trivial.

```php
$view->user = User::get(1);

echo $this->view->render('user.phtml');
```

Using the pattern that [graze/formatter](https://github.com/graze/formatter) defines we've reduced the size  of the context that's being passing to views. What we're passing has also become much more clear.

```php
class UserFormatter extends \Graze\Formatter\AbstractFormatter
{
    public function convert($object)
    {
        return [
            'first_name' => $object->getFirstName(),
            'last_name' => $object->getLastName(),
        ];
    }
};

$formatter = new UserFormatter();
$user = User::get(1);

echo $twig->render('user.twig', [
    'user' => $formatter->format($user),
);
```

The power of the library comes from registering [processors](https://github.com/graze/formatter/blob/master/docs/01-processors.md) with the formatter. While `UserFormatter` is a _very_ reusable class, different views will need different information.

Say we want all the ratings information for a user in another view:

```php
$ratingService = new RatingService();

$processor = function (array $data, User $user) use ($ratingService) {
    $data['ratings'] = $ratingService->findAllByUser($user)->toArray();
    return $data;
};

$formatter = new UserFormatter();
$formatter->addProcessor($processor);

$user = User::get(1);

echo $twig->render('ratings.twig', [
    'user' => $formatter->format($user),
);
```

No changes to `UserFormatter` are required, and we've not affected any other views, and if we define `$processor` as a class it'd be fairly reusable too.
