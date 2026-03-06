# If and When

A Jekyll theme and site for [ifandwhen.com](https://ifandwhen.com).

## Setup

### Prerequisites

- Ruby 3.2+
- Bundler

### Local development

```bash
git clone https://github.com/yourusername/ifandwhen.git
cd ifandwhen
bundle install
bundle exec jekyll serve
```

Site runs at `http://localhost:4000`.

---

## Writing essays

Create a new file in `_posts/` following Jekyll's naming convention:

```
_posts/YYYY-MM-DD-slug-here.md
```

### Front matter

```yaml
---
layout: essay
title: "Your Title Here"
subtitle: "One or two sentences. This appears as the lede under the title and in the post listing."
kicker: "Essay"          # appears above the title — "Essay", "Field Notes", etc.
date: 2025-04-01
author: "Scot Campbell"
read_time: 10            # minutes, shown in the header
---
```

Then write the body in Markdown.

---

## Special includes

### Pull quote

```liquid
{% include pull-quote.html quote="The text of your pull quote goes here." %}
```

### Two-column comparison box

```liquid
{% include comparison.html
  label_a="Label for left column"
  phrase_a="The key phrase on the left"
  desc_a="A sentence or two describing the left side."
  label_b="Label for right column"
  phrase_b="The key phrase on the right"
  desc_b="A sentence or two describing the right side."
%}
```

### Section break

Use a standard Markdown horizontal rule — it renders as the styled section break:

```markdown
---
```

---

## Deployment

Push to `main`. The GitHub Actions workflow in `.github/workflows/deploy.yml` builds with Jekyll 4 and deploys automatically.

### Custom domain

The `CNAME` file is already set to `ifandwhen.com`. In your GitHub repo settings under **Pages**, set the custom domain to `ifandwhen.com` and enable HTTPS.

In your DNS provider, add:

| Type  | Name | Value                    |
|-------|------|--------------------------|
| A     | @    | 185.199.108.153          |
| A     | @    | 185.199.109.153          |
| A     | @    | 185.199.110.153          |
| A     | @    | 185.199.111.153          |
| CNAME | www  | yourusername.github.io   |

---

## Content types

| Layout  | Use for                          | Front matter `kicker`     |
|---------|----------------------------------|---------------------------|
| `essay` | Long-form pieces (default)       | `Essay`                   |
| `essay` | Shorter observational writing    | `Field Notes`             |
| `note`  | Brief thoughts, no drop cap      | `Note`                    |

Notes live in `_notes/` (a Jekyll collection). Essays and field notes live in `_posts/`.
