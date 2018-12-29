# graze tech blog

![gif of Lisa Simpson saying "There are gonna be a lot of heated blogs on this topic"](https://media.giphy.com/media/iSrYjghqHhRJu/giphy.gif)

This is the source for the [graze tech blog](https://tech.graze.com).

It is hosted on [GitHub Pages](https://pages.github.com/) and powered by [Jekyll](https://jekyllrb.com/).

## Setup

```
make deps
```

## Run

```
make start
```

This will start up a local copy of the blog at <http://localhost:4000>.

## Creating a new post

1. Create a new branch for the post.
1. `make start`
1. Run `make new-post`, fill in the generated post and rename it to have a sensible slug.
1. If the author of the post does not exist, run `make new-author` and fill in those contents.
1. Check that the post displays correct on the post index page and also as a standalone post.
1. If a new author was created, check that the author page displays correctly.
1. Submit a PR as per usual.
1. Merge into `master` when the PR is approved. This will automatically deploy to GitHub Pages.
