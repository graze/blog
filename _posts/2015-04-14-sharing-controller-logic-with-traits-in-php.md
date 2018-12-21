There have been a few times I have come across a situation where I need to share some logic between controllers but it hasn't been as clear cut as abstracting that logic out into a library. I've been pondering the best way to tackle this problem and would like to share my thoughts. Take this code as an example, which is similar to some legacy code I came across recently:

```prettyprint lang-php
<?php

/**
 * We need the customer to be able to add a new address from their account page
 */
class AccountController
{
    public function lookupPostalCode(Request $request, LookupService $lookupService)
    {
        $addresses = $lookupService->lookup($request->get('postcode'));

        if (count($addresses) == 0) {
            return redirect()->back(); // no addresses, return with errors
        } elseif ($request->isFromUk() && count($addresses) > 1) {
            return view('address.select', $addresses); // we need them to pick from a range of possible addresses
        } else {
            $partialAddress = reset($addresses);
            return view('address.confirm', $partialAddress);
        }
    }
}

/**
 * We need the customer to add an address when they signup
 */
class SignupController
{
    public function lookupPostalCode(Request $request, LookupService $lookupService)
    {
        $addresses = $lookupService->lookup($request->get('postcode'));

        if (count($addresses) == 0) {
            return redirect()->back(); // no addresses, return with errors
        } elseif ($request->isFromUk() && count($addresses) > 1) {
            return view('address.select', $addresses); // we need them to pick from a range of possible addresses
        } else {
            $partialAddress = reset($addresses);
            return view('address.confirm', $partialAddress);
        }
    }
}
```

We have two controllers, one for existing customers and one for new customers signing up to the website. In both instances we need to provide the ability for an address to be added using a postal code lookup service. There is some logic that says depending on the response from the postal code lookup service, we respond to the customer in different ways.

Currently this logic is duplicated in both controllers. This instinctively feels wrong, especially when we consider such principles as Don't Repeat Yourself, this is quite important logic and we don't want there to be scope to introduce inconsistencies.

How can we make this better? Let's try solving by extension...

### Extension

```prettyprint lang-php
<?php

abstract class AddAddressController
{
    public function lookupPostalCode(Request $request, LookupService $lookupService)
    {
        $addresses = $lookupService->lookup($request->get('postcode'));

        if (count($addresses) == 0) {
            return redirect()->back(); // no addresses, return with errors
        } elseif ($request->isFromUk() && count($addresses) > 1) {
            return view('address.select', $addresses); // we need them to pick from a range of possible addresses
        } else {
            $partialAddress = reset($addresses);
            return view('address.confirm', $partialAddress);
        }
    }
}

/**
 * We need the customer to be able to add a new address from their account page
 */
class AccountController extends AddAddressController
{
}

/**
 * We need the customer to add an address when they signup
 */
class SignupController extends AddAddressController
{
}
```

Fantastic, we can move the shared logic into a `AddAddressController` that can be extended by both `SignupController` and `AccountController`. Now the logic is in one place but shared by both controllers, goal achieved!

But let's think about this for second, this means that everywhere we want to add an address, we need to extend that controller, does that make sense? Is this approach going to end up with a messy inheritance tree when we share other logic between these controllers?

Hmm, well let's try moving the logic into a library...

### Library Code

```prettyprint lang-php
<?php

class AddAddressHandler
{
    protected $request;
    protected $lookupService;

    public function __construct(Request $request, LookupService $lookupService)
    {
        $this->request = $request;
        $this->lookupService = $lookupService;
    }

    public function lookupPostalCode($postalCode)
    {
        $addresses = $this->lookupService->lookup($postalCode);

        if (count($addresses) == 0) {
            return redirect()->back(); // no addresses, return with errors
        } elseif ($request->isFromUk() && count($addresses) > 1) {
            return view('address.select', $addresses); // we need them to pick from a range of possible addresses
        } else {
            $partialAddress = reset($addresses);
            return view('address.confirm', $partialAddress);
        }
    }
}

class AccountController
{
    public function lookupPostalCode(Request $request, AddAddressHandler $handler)
    {
        return $handler->lookupPostalCode($request->get('postcode'));
    }
}

class SignupController
{
    public function lookupPostalCode(Request $request, AddAddressHandler $handler)
    {
        return $handler->lookupPostalCode($request->get('postcode'));
    }
}
```

We've moved our logic into a library class called `AddAddressHandler` and then we're injecting this into our controllers and invoking it using the requested postcode. We have managed to share our logic between controllers *and* we have avoided any inheritance problems too. However, we now have a library class which is doing things with views and redirecting requests. This tramples all over the idea behind separation of concerns and is putting presentation and request logic into our domain layer. Thereby coupling our domain layer to our current web application framework, not very smart.

So what next?

### Trait

```prettyprint lang-php
<?php

trait AddAddressTrait
{
    public function lookupPostalCode(Request $request, LookupService $lookupService)
    {
        $addresses = $lookupService->lookup($request->get('postcode'));

        if (count($addresses) == 0) {
            return redirect()->back(); // no addresses, return with errors
        } elseif ($request->isFromUk() && count($addresses) > 1) {
            return view('address.select', $addresses); // we need them to pick from a range of possible addresses
        } else {
            $partialAddress = reset($addresses);
            return view('address.confirm', $partialAddress);
        }
    }
}

/**
 * We need the customer to be able to add a new address from their account page
 */
class AccountController
{
    use AddAddressTrait;
}

/**
 * We need the customer to add an address when they signup
 */
class SignupController
{
    use AddAddressTrait;
}
```

We've moved our logic into a trait, a trait can be shared between many controllers without inheritance and it's more reasonable to do things with views and redirects here (though still not ideal). This in my eyes is the best solution to the problem, it's what traits are good for and it's quite convenient. Need a controller with the ability to add addresses? Add a one-line `use` statement and you're done.


**What are your thoughts? Have you encountered this problem before? How did you solve it?**