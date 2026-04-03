# AGENTS.md - Guidelines for Agentic Coding Agents

## Project Overview
Academic personal website for Jiyu Hu (UIUC CS Graduate Student), built with **Jekyll** using the **Academic Pages** template (fork of Minimal Mistakes). Hosted on GitHub Pages.

## Build / Dev Commands

### Local Development
```bash
bundle install              # Install Ruby dependencies (first time)
bundle exec jekyll serve -l -H localhost   # Start dev server with live reload
```

### JavaScript Build
```bash
npm install                 # Install Node dependencies (first time)
npm run build:js            # Minify JS into assets/js/main.min.js
npm run watch:js            # Watch JS files and auto-rebuild
```

### Docker
```bash
./start_docker.sh           # Start via Docker
```

## Testing
**No test framework is configured.** This is a static site; verify changes by running the dev server and inspecting the rendered output in a browser.

## Linting / Formatting
**No linting or formatting tools are configured.** Follow existing code style manually (see below).

## Content Conventions

### File Naming
- Posts: `_posts/YYYY-MM-DD-slug.md`
- Publications: `_publications/YYYY-MM-DD-Title-With-Dashes.md`
- Talks: `_talks/YYYY-MM-DD-title.md`
- Portfolio: `_portfolio/slug.md`

### Front Matter
All content files use YAML front matter. Required fields by type:

**Posts**: `title`, `date`, `permalink`, optionally `tags`, `author_profile`, `related`
**Publications**: `title`, `collection: publications`, `link`, `author`, `date`, `venue`, `citation`
**Talks**: `title`, `collection: talks`, `date`, `venue`, `location`

### Markdown
- Uses **kramdown** with **GFM** (GitHub Flavored Markdown) input
- Excerpt separator: `\n\n`
- Code blocks use standard GFM triple-backtick syntax with language tags

## Code Style

### HTML / Liquid Templates
- Use 2-space indentation
- Liquid tags: `{% tag %}` and `{{ variable }}` with single spaces inside delimiters
- Include partials via `{% include filename.html %}` from `_includes/`
- Layouts live in `_layouts/`; reference via `layout: name` in front matter

### SCSS
- Files in `_sass/`, imported from `assets/css/main.scss`
- Style output: compressed (production)
- Follow existing naming: underscores for partials (`_base.scss`, `_sidebar.scss`)

### JavaScript
- Source files in `assets/js/` and `assets/js/plugins/`
- Main entry: `assets/js/_main.js`
- Output: `assets/js/main.min.js` (auto-generated, do not edit)
- Uses jQuery 3.x

### YAML / Config
- 2-space indentation
- Strings with special characters should be quoted
- Site-wide settings in `_config.yml` (requires server restart to take effect)
- Navigation in `_data/navigation.yml`
- Author info in `_data/authors.yml`

## Key Directories
| Path | Purpose |
|------|---------|
| `_pages/` | Main site pages (about, CV, etc.) |
| `_posts/` | Blog posts |
| `_publications/` | Publication entries |
| `_talks/` | Talk entries |
| `_portfolio/` | Portfolio entries |
| `_layouts/` | Jekyll layout templates |
| `_includes/` | Reusable HTML partials |
| `_sass/` | SCSS stylesheets |
| `_data/` | Site data (YAML) |
| `assets/` | Static assets (CSS, JS, fonts) |
| `images/` | Images and favicons |
| `files/` | Downloadable files (e.g., CV PDF) |

## Git / Workflow
- Branch off `main` (or `gh-pages` if that is the deploy branch)
- `_site/`, `node_modules/`, `Gemfile.lock`, and `local/` are gitignored
- No CI/CD beyond GitHub Pages automatic deployment

## Notes
- `_config.yml` changes require restarting the Jekyll server
- Collections (`publications`, `talks`) output pages via `output: true` in config
- Use `bundle exec` prefix for all Jekyll commands to ensure correct gem versions
