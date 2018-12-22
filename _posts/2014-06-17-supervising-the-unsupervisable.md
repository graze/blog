---
title: "supervising the unsupervisable"
date: 2014-06-17T10:29:12.000Z
author: graze-tech
---

As systems scale and react to growing user numbers, the way you use and transform your data changes. You'll probably build towards a system that works around processing queues, batch processing within daemons and pools of workers. There are many languages that are designed with this in mind, but in reality, we sometimes have to deal with this type of system in languages best suited to simpler tasks.

![Four, Five, FIRE!][moss]

Supervising child processes can be difficult without the proper tools. Processes can fail unexpectedly, logically related scripts won't know their siblings have disappeared, and extra work will likely ensue. That's why we've written a simple library, aptly named [Supervisor][gh-sup], in an attempt to supervise these processes within our PHP applications.

```php
use Graze\Supervisor\ProcessSupervisor;
use Symfony\Component\Process\Process;

$while = new Process('/usr/bin/python while_true.py');

$sup = new ProcessSupervisor($while);
$sup->start();
$sup->supervise();
```

This will run your `while_true.py` process and monitor its status. If the process terminates unexpectedly, the supervisor steps in and attempts to handle it as gracefully as possible. You can configure the supervisor to retry your process, notify your team via pagerduty, or add your own custom handlers.

To find out more about how to use the supervisor library to handle your processes, please read the [documentation on github][gh-sup].

[gh-sup]: https://github.com/graze/supervisor
[moss]: /content/images/2014/Jun/moss.gif

> by [Andrew Lawson](https://github.com/adlawson)
