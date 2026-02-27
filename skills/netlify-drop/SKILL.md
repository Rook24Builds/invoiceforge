# Netlify Drop Deployment

Deploy static sites in 30 seconds without accounts, config, or CLI.

## When to Use
- Need landing page NOW (no time for setup)
- No domain yet (use Netlify subdomain)
- Static HTML/CSS/JS only
- Prototyping or temporary hosting

## The Process

### 1. Create Your Site
```bash
# Single file
index.html

# Or folder structure
landing-page/
├── index.html
├── style.css
├── script.js
└── assets/
    └── image.png
```

### 2. Deploy (30 seconds)
1. Go to https://app.netlify.com/drop
2. Drag folder into browser window
3. Get instant live URL: `https://random-name-12345.netlify.app`

### 3. Make Permanent (Optional)
- Free accounts keep sites live forever
- Same URL stays active
- Custom domains available (Pro)
- Builds from GitHub (Pro)

## Why This Works
- **No build step:** Static files only
- **No dependencies:** Zero config
- **Instant:** 10 second deploy
- **Free tier:** Generous limits

## Limitations
- 1 hour persistence without account
- Random subdomain names
- No server-side processing
- Build tools not available (use GitHub integration for that)

## Comparison
| Platform | Time | Account? | Custom Domain? |
|----------|------|----------|----------------|
| Netlify Drop | 30s | No | No (temp) |
| Carrd | 2min | Yes | On paid tiers |
| GitHub Pages | 5min | Yes | Yes |
| Vercel | 2min | Yes | Yes |

## Best For
- ✅ Quick landing pages
- ✅ Portfolio sites
- ✅ Static documentation
- ✅ 24h sprint builds
- ❌ Dynamic apps (need backend)
- ❌ Complex builds (CI/CD needed)
