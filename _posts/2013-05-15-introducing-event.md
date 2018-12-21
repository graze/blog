Today we're proud to announce our first open source library, [Event][event]. We're releasing it as part of our increased efforts to contribute to the open tech community. The library once lived its life as part of our internal systems, but making the source public was a no-brainer.

Event itself is a really simple synchronous <abbr title="Publish/Subscribe">pub/sub</abbr> library for PHP. If you're unfamiliar with pub/sub, it's a really non-intrusive way to listen to emitted events or messages. Event listeners subscribe in advance to the event names and are invoked when the events are emitted.

As with all event based systems, loose coupling of your listeners is the main advantage. The loosely coupled behaviour can also be its biggest downfall, though, if it's not used carefully. If you follow one golden rule, you'll never go wrong:

> Your dispatcher should *never* assume that a certain subscriber is listening.

What this really means is you shouldn't depend on events to control your application flow. Events should really be reserved for other, non-critical services like logging, data collection or console output. You should be free to emit events without asserting anything actually happens.


## How easy is it to use? ##
To subscribe to an event, you only need to implement the `getSubscribedEvents` method from `Graze\Event\EventSubscriberInterface`. This routes an event to the method of the same name in the subscriber.

<?prettify?>
    <?php

    class FooSubscriber implements Graze\Event\EventSubscriberInterface
    {
        public function getSubscribedEvents()
        {
            return array(
                'event' => 'onEvent'
            );
        }

        public function onEvent()
        {
            echo 'Hello, World!';
        }
    }

    $dispatcher = new Graze\Event\EventDispatcher();
    $dispatcher->addSubscriber(new FooSubscriber());

    $dispatcher->dispatch('event'); // Hello, World!


## Where can I get it? ##
More information, including documentation and installation instructions, is available on the project page at [github.com/graze/event][event]. We're always open to feedback and contributions to anything we open source.

Happy coding!

<!-- Links -->
[event]:  http://github.com/graze/event

> By [Andrew Lawson](https://github.com/adlawson)