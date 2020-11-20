# bonfire.link websites monorepo

This repository contains all bonfire.link branded websites.

## structure

All site subdirectories live under `sites/`. They rely on [Hugo](https://gohugo.io/) as the static site generator and [Webpack](https://webpack.js.org/) as the asset pipeline.

```
sites
├── landing
├── ...
```

An additional `.common/` subdirectory exists under `sites/`, exclusively containing files shared among sites. These files are made available to sites via symlinking.

## development

Before getting started, you will need:
- [Git](https://git-scm.com/downloads) and [GNU Make](https://www.gnu.org/software/make/).
- [Node.js](https://nodejs.org/en/download/) and [nvm](https://github.com/nvm-sh/nvm).

First, to clone this repo, run:

```sh
git clone git@github.com:bonfirelink/websites.git
```

Once cloned, make sure you have the right version of `node` installed with `nvm`:

```sh
nvm use
```

You can now list all available sites running:

```sh
make list
```

To install all packages for the site you want to work on, run:

```sh
make install site=<site>
```

To start the site locally, run:

```sh
make start site=<site>
```

Or to start multiple sites, specify different port values:

```sh
PORT=3001 make start site=<site>
```

To build a static version of the site inside the site's `dist/` subdirectory, run:

```sh
make build site=<site>
```

### digging deeper

You can read more details and options about starting and building sites in their respective `README.md` file.
