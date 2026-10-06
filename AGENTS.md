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

## Local hosting on Windows
- Always host the site in the WSL distro `Ubuntu-24.04`, not natively on Windows (no Ruby there) or in `Ubuntu-20.04`.
- Ruby is apt's `ruby-full` (3.2.3); gems live in a user-level `GEM_HOME`, so no `sudo` is needed. Serve the repo in place from `/mnt/c`:
  ```bash
  export GEM_HOME="$HOME/.gem/ruby" PATH="$HOME/.gem/ruby/bin:$PATH"
  cd /mnt/c/Users/hu_ji/github/personal_webpage
  bundle exec jekyll serve -l -H localhost --force_polling
  ```
- Use `-H localhost`, never `-H 0.0.0.0`: Jekyll 3 sets `site.url` to `http://<host>:4000`, so `0.0.0.0` makes every CSS/JS link point at `http://0.0.0.0:4000/...`, which Windows browsers block (site renders unstyled). WSL2 forwards `localhost` to Windows, so `http://localhost:4000` works.
- `--force_polling` is needed for auto-regeneration on `/mnt/c`.
- From PowerShell, wrap commands in a script and run `wsl -d Ubuntu-24.04 -e bash <script>`. Inline `bash -c "..."` quoting breaks when passed through PowerShell.

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
