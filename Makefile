start:
	bundle exec jekyll serve

deps:
	bundle install

new-post:
	cp templates/post.md _posts/$(shell date +%Y-%m-%d)-post-slug.md

new-author:
	cp templates/author.md _authors/author-slug.md
