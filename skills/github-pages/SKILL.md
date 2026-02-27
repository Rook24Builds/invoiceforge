# GitHub Pages Deployment

Free, permanent hosting for static sites with custom domains.

## When to Use
- Static sites (HTML/CSS/JS)
- Documentation
- Portfolio pages
- Landing pages
- Project showcases

## Deployment Steps

### 1. Create Repository
```bash
gh repo create owner/repo-name --public --description "Your description"
```

### 2. Push Files
```bash
git init
git remote add origin https://github.com/owner/repo-name.git
git add .
git commit -m "Initial commit"
git push -u origin master  # or main
```

### 3. Enable GitHub Pages
```bash
echo '{"source":{"branch":"master","path":"/"}}' | \
  gh api repos/owner/repo-name/pages --method POST --input -
```

### 4. Get URL
Output shows: `https://owner.github.io/repo-name/`

## Features
- **HTTPS enforced** automatically
- **Custom domains** supported (CNAME file)
- **Free forever** for public repos
- **Auto-deploy** on every push
- **Jekyll support** built-in

## Limitations
- Static files only (no server-side)
- Public repos only (free tier)
- 1GB repo size limit
- 100GB bandwidth/month

## Best For
- ✅ Landing pages
- ✅ Documentation
- ✅ Portfolio sites
- ✅ Project demos
- ❌ Dynamic apps (need backend)

## Pro Tips
- Use `index.html` in root for homepage
- Custom domain: Add `CNAME` file with domain name
- Private repos: Need GitHub Pro for Pages
