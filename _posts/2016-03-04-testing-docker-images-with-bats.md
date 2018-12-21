---
title: "testing docker images with bats"
date: 2016-03-04T17:22:03.000Z
author: sam-parkinson
---

The [Bash Automated Testing System](https://github.com/sstephenson/bats) (Bats) is a testing framework for Bash I came across recently, in use by the amazing [Apline Linux Docker images](https://github.com/gliderlabs/docker-alpine/tree/master/test).

> It provides a simple way to verify that the UNIX programs you write behave as expected.
> 
> A Bats test file is a Bash script with special syntax for defining test cases. Under the hood, each test case is just a function with a description.

We've started using it to test our Docker images too, see the [graze/composer](https://github.com/graze/docker-composer) image for an open-source example.

Here's what a typical test looks like:

```prettyprint lang-bash
@test "composer version is correct" {
  run docker run --rm graze/composer:php-7.0 --version --no-ansi
  echo 'status:' $status
  echo 'output:' $output
  version="$(echo $output | awk '{ print $3 }')"
  echo 'version:' $version
  [ "$status" -eq 0 ]
  [ "$version" = "1.0-dev" ]
}
```

It means we can now apply <abbr title="Test Driven Development">TDD</abbr> when making any changes, helping to protect the continuous delivery pipeline.

Going beyond Bats, it looks like [RSpec and ServerSpec make for a create combination](https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec) for testing your images too, with a neat <abbr title="Domain-Specific Language">DSL</abbr>.
