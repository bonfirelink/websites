# website framework

This framework:
- Forked from [Victor Hugo framework](https://github.com/netlify-templates/victor-hugo).

This website:
- Builds with [Hugo](https://gohugo.io/) static site generator.
- Uses [Bulma](https://bulma.io/) for styling.
- Uses [WebPack](https://webpack.js.org/) for asset processing.
- Uses [Babel](https://babeljs.io/) for JavaScript transpiling.
- Uses [PostCSS](http://postcss.org/) for CSS compiling.

## usage

### 🛠 development

```bash
npm install
```

This will take some time and will install all packages necessary to run all tasks.

While developing the website, use:

```bash
npm start
```

or for developing your website with `hugo server --buildDrafts --buildFuture`, use:

```bash
npm run preview
```

Then visit http://localhost:3000/ _- or a new browser windows popped-up already -_ to preview your new website. Webpack Dev Server will automatically reload the CSS or refresh the whole page, when stylesheets or content changes.

### 📦 static build

To build a static version of the website inside the `/dist` folder, run:

```bash
npm run build
```

To get a preview of posts or articles not yet published, run:

```bash
npm run build:preview
```

See [package.json](package.json#L8) for all tasks.

## structure

```
├─ site/               // Everything in here will be built with hugo
│  ├─ content/         // Pages and collections - ask if you need extra pages
│  ├─ data/            // YAML data files with any data for use in examples
│  ├─ layouts/         // This is where all templates go
│  │  ├─ partials/     // This is where includes live
│  │  ├─ index.html    // The index page
│  ├─ static/          // Files in here ends up in the public folder
│
├─ src/                // Files that will pass through the asset pipeline
│  ├─ scss/            // Webpack will bundle imported scss files separately
│  │  ├─ common.scss@  // common.scss contains cross-site style and changes will affect all sites
│  │  ├─ main.scss     // main.scss contains site-specific style
│  ├─ index.js         // index.js is the webpack entry for your scss & js assets
```

Note that, like `common.scss@`, there are other symlinks to files under `sites/.common` and changes will affect all sites.

## basic concepts

You can read more about Hugo's template language in their documentation here:
- https://gohugo.io/templates/overview/

The most useful page there is the one about the available functions:

- https://gohugo.io/templates/functions/

For anything related to styling, get familiar with Bulma:

- https://bulma.io/documentation/

For assets that are completely static and don't need to go through the asset pipeline, use the `site/static` folder. Images, font-files, etc, all go there.

Files in the static folder end up in the web root. So a file called `site/static/favicon.ico` will end up being available as `/favicon.ico` and so on...

The `src/index.js` file is the entrypoint for webpack and will be built to `/dist/main.js`

You can use **ES6** and use both relative imports or import libraries from npm.

Any CSS file imported into the `index.js` will be run through Webpack, compiled with [PostCSS Next](http://cssnext.io/), and minified to `/dist/[name].[hash:5].css`. Import statements will be resolved as part of the build.

## environment variables

To separate the development and production _- aka build -_ stages, all gulp tasks run with a node environment variable named either `development` or `production`.

You can access the environment variable inside the theme files with `getenv "NODE_ENV"`. See the following example for a conditional statement:

```
{{ if eq (getenv "NODE_ENV") "development" }}You're in development!{{ end }}
```

All tasks starting with _build_ set the environment variable to `production` - the other will set it to `development`.
