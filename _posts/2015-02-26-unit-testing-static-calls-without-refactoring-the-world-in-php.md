---
title: "Unit testing static calls without refactoring the world in PHP"
date: 2015-02-26T12:16:38.000Z
tags: [php, unit-testing, static-method]
author: Will Pillar
---

Imagine you have a situation like this in some legacy code:

```prettyprint lang-php
class Bar
{
    public static function doSomethingElse()
    {
        return 'Bar Bar Black Sheep';
    }
}

class Foo
{
    public function doSomething()
    {
        return Bar::doSomethingElse();
    }
}
```

`Foo` is calling the static function on `Bar` and that method is also used by 50 other classes in the same way. Currently we can't unit test this as we can't mock out the `doSomethingElse()` call. So what do we do? Well we have two options really:

- Leave it and move on - accept that it can't be unit tested and write a functional test instead.
- Refactor `Bar` to be non-static and refactor the 50 other occurrences of it too.

Neither of which is very appealing. If `Bar::doSomethingElse()` touches the database for example, then the first option is going to cause us some problems. The second option, whilst idealistic, is not practical. (Who knows how long it's going to take to refactor all 50 occurrences? What if we encounter 10 other issues along the way and need to resolve those too?)

There is, however, a third option that gains us the ability to unit test `Foo` without having to touch `Bar` at all. We can create a 'proxy' of `Bar` that is non-static. Let's have a look at how that would work:


```prettyprint lang-php
class BarProxy
{
    public function doSomethingElse()
    {
        return Bar::doSomethingElse();
    }
}
```

We create a new class with a non-static method `doSomethingElse()` and the only thing that method does is return the result of a call to `Bar::doSomethingElse()`, the static method we've been dealing with. Now let's implement that in `Foo`:

```prettyprint lang-php
class Foo
{
    protected $bar;
    
    public function __construct(BarProxy $bar)
    {
        $this->bar = $bar;
    }
    
    public function doSomething()
    {
        return $this->bar->doSomethingElse();
    }
}
```

Now we can mock `BarProxy` and inject the mock in our unit test for `Foo` - in doing so we gain the ability to unit test `Foo`. 
This is a useful way of writing unit testable classes on codebases that have a lot of static calls without re-writing the entire codebase. We've found it to be especially useful for proxying classes like `Session` or `Cache` which traditionally cause problems in functional testing.

There are some caveats with proxy classes to be aware of:

- We accept that we can't unit test `BarProxy`. This should be ok **as long as `BarProxy` is only calling its static version**. Each method on a proxy class should be one line of code with one call to that static version.
- In classes that have a lot of static calls, you may find you end up with 6 or 7 proxies being injected into your class. If you do have a lot of dependencies then your class may be doing too much. Maybe it's time to separate some of that functionality out into smaller classes.


**What do you think of this approach? Have you come across this problem before? How did you solve it?**