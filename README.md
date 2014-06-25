Changes to the default Jekyll config:

* Posts live in the `_posts-raw` directory. The `_posts` directory is auto-generated from the content in the `_posts-raw` directory.
* Posts and their metadata are split up. Metadata lives in `*.yml` files in the same directory as the post.
* Build is triggered via `rake build`, not `jekyll build`.