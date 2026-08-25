# marko-medvedev.github.io

Personal academic homepage — plain HTML/CSS with a few lines of JS, served by GitHub Pages
at <https://marko-medvedev.github.io/>.

```
index.html          the whole page
css/style.css       styling (light + dark, responsive, print)
js/main.js          footer year + email de-obfuscation
assets/             portrait, favicon
```

## Editing

**Add a publication** — copy one `<li class="pub">` block in `index.html` and change the fields:

```html
<li class="pub">
  <h3 class="pub-title"><a href="ARXIV_URL">Title</a></h3>
  <p class="pub-authors"><b>Marko Medvedev</b>, Coauthor, Coauthor</p>
  <p class="pub-meta"><span class="venue">VENUE YEAR</span><a class="pill" href="ARXIV_URL">arXiv</a></p>
</li>
```

Use `<span class="venue venue-quiet">Submitted</span>` for preprints (grey instead of blue),
and add more `<a class="pill">` links (PDF, Code, BibTeX, Slides) as needed.

**Preview locally**

```bash
python3 -m http.server 8000   # then open http://localhost:8000
```

**Publish** — push to `main`; GitHub Pages redeploys automatically.

## Old URL

`https://math.uchicago.edu/~medvedev/` serves `uchicago-redirect/index.html`
(from this repo), which redirects here.
