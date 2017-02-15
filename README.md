# Artour

A CMS and blog for photography and artwork.


## Getting Started
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:3000`](http://localhost:3000) from your browser.

## Custom Mix Tasks
	* Render site to static HTML files `mix distill.html`
	* Copy static assets for static site `mix distill.static`
	* Convenience task to combine previous two tasks `mix distill.site`
	* Add new images to a given post `mix artour.add_new_images_to_post 7 3` (adds the 3 newest images to post with post_id of 7)
	* Test image urls for 404s `mix distill.test.image_urls image_url/folder/` (note trailing slash following url)
