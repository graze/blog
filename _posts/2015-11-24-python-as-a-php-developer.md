---
title: "Python as a PHP Developer"
date: 2015-11-24T11:48:32.000Z
tags: [php, python]
author: will-pillar
---

The majority of the code I've written in my 3 and a half years of professional software development has been PHP. Recently I built my first Python web application for a REST JSON API. I thought I'd share my first experience of Python from the perspective of someone who's predominantly been a PHP developer.

- Decorators are awesome! They do seem easy to abuse though.

- The virtual env was really nice, a great way of separating the project and its dependencies from the host.

- Python doesn't really do OOP. From what I've read and tried out, you can define classes but you can't have abstract classes or interfaces. You can have inheritance but working with parent instance variables requires a meta class which was a bizarre concept to me. There doesn't seem to be any public, private or protected member / method access and the distinction between static and non-static seems quite arbitrary.

- No type-hints, this bugged me. For the very few classes I did have, I really wanted to type-hint for them and couldn't.

- Python's standard libraries are great, seems like it follows the 'one way to do something' pattern. Whenever I needed to google for some help the answers were always pretty consistent. When I do that for PHP there's a much larger disparity in the answers, each with their own nuances. They also have sensible APIs, not once was I surprised by a function name or which module it belonged to.

- Indentation, it took a while to get used to the indentation of Python and in my opinion the indentation combined with no braces makes writing readable code hard.

- I found Python much quicker to write than PHP, I think the indentation combined with the lack of braces was a factor, it certainly felt like I was accomplishing a lot more in the same time.

- Docstrings inside the function, this was weird. I don't know why Python docstrings need to be inside the body of a function. There always doesn't seem to be any support for tags like `@return` `@param` etc which are useful in PHP doc blocks.

- Project organisation, I couldn't find any good examples of how to structure a Python project. I looked at some of the open source libs I was using but some had a single .py file with all the code, others that a couple of .py files with a mixture of code between them.

- Named parameters are very useful, but they do feel like some syntactic sugar to abstract away the fact that your function has too many arguments. But it sure beats having to do `method(false, true, null, 0, $ignore, null)` in PHP. They are probably more useful for functions where you would have an array of config with N possible keys but instead you want them as first class variables.

Overall the experience has been positive, I would definitely come back to Python for the right project. 'right project' being the operative phrase. Like anything Python is more fit for some purposes than others, it does not excel as an OOP language and because it allows OOP-ish features it does not excel as a functional language either.

If you want to quickly put up a web application with minimal complexity or write a command-line tool for development, Python is a solid choice. If I was going to be building anything that could conceivably be described as 'monolithic' or would benefit from the comfort of type-safety, I don't think I would choose Python.
