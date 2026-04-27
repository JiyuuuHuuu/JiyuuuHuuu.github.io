# AGENTS.md

## What this repo is
- Personal academic site built on Academic Pages (Jekyll + Minimal Mistakes style structure).
- No CI workflows in `.github/workflows`; validate changes locally.

## Dev commands (verified)
- Ruby version file is `.ruby-version` = `3.2.2`.
- Install Ruby deps: `bundle install`
- Run site locally (use `bundle exec`): `bundle exec jekyll serve -l -H localhost`
- Install JS deps: `npm install`
- Rebuild JS bundle: `npm run build:js`
- JS watch mode: `npm run watch:js`
- Docker helper: `./start_docker.sh` (builds `.devcontainer/Dockerfile` image `personal-website` if missing, then runs container with repo mounted and port `4000:4000`).

## Verification expectations
- No automated tests/lint/typecheck configured.
- Usual verification is running Jekyll locally and checking rendered pages in browser.

## Critical wiring / gotchas
- `_config.yml` changes require restarting the Jekyll server (Jekyll does not hot-reload config).
- `assets/js/main.min.js` is tracked and generated from `assets/js/_main.js` + `assets/js/plugins/*.js` via `npm run build:js`; if source JS changes, commit rebuilt `main.min.js` too.
- Jekyll `exclude` in `_config.yml` excludes `assets/js/_main.js` and `assets/js/plugins` from site output, so runtime JS comes from `assets/js/main.min.js`.
- Home page content is `_pages/about.md` with `permalink: /`.
- `_layouts/single.html` has custom logic: on home page it forces title text to `About Me` and hardcodes a CV link (`/files/jiyuhu_cv.pdf`).

## Content structure that matters
- Main nav links are in `_data/navigation.yml`.
- Collections with output pages: `_publications/` and `_talks/` (`output: true` in `_config.yml`).
- `portfolio` collection exists but is configured `output: false`.

## Content generation scripts
- `markdown_generator/publications.py` and `markdown_generator/talks.py` write output to `../_publications/` and `../_talks/`; run them from inside `markdown_generator/`.
- `talkmap.py` is intended to run from `_talks/` and writes map artifacts to `../talkmap/`.

## Git/worktree notes
- Current branch is `master`.
- `.gitignore` ignores `_site/`, `local/`, `node_modules`, `package-lock.json`, and `Gemfile.lock`.
