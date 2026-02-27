# KITE AI Image Prompts

## 1. Product Thumbnail (Primary)
**Model:** Flux 2 Pro (1K) — 5 credits ($0.025)

**Prompt:**
```
Modern minimalist Notion dashboard mockup for freelancers, clean UI showing client list and invoice tracking system, purple and white color scheme with subtle gradients, floating 3D elements, soft shadows, professional SaaS product thumbnail, high quality render, no text
```

**Settings:**
- Resolution: 1K
- Aspect Ratio: 1:1 (square, perfect for Gumroad thumbnail)

---

## 2. Hero Image (Optional - if needed)
**Model:** Flux 2 Pro (1K) — 5 credits ($0.025)

**Prompt:**
```
Freelancer workspace flat lay, laptop showing organized dashboard, coffee cup, notebook, clean aesthetic, soft natural lighting, productivity theme, warm neutral tones with purple accent, professional photography style
```

**Settings:**
- Resolution: 1K
- Aspect Ratio: 16:9 (banner style)

---

## Total Cost
- Thumbnail (DONE): 5 credits = $0.025
- **Actual spend: $0.025**

## Generated Image URL
https://tempfile.aiquickdraw.com/f/a12c5279-e2ea-4176-9f5e-27f75d53bf60_0.jpg

## API Call Structure
```bash
curl -X POST https://api.kie.ai/api/v1/jobs/createTask \
  -H "Authorization: Bearer API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "flux-2/pro-text-to-image",
    "input": {
      "prompt": "PROMPT_HERE",
      "aspect_ratio": "1:1",
      "resolution": "1K"
    }
  }'
```

Then check status:
```bash
curl "https://api.kie.ai/api/v1/jobs/recordInfo?taskId=TASK_ID" \
  -H "Authorization: Bearer API_KEY"
```

---

**EXECUTE:** Run thumbnail generation first. If it looks good, that's all we need.
