# Migration to Cloudflare Wrangler

## Overview

This document explains the migration from using the third-party `cloudflare/pages-action` GitHub Action to using Cloudflare's official **Wrangler CLI** for deployment.

## Important Clarification

**Cloudflare Pages is NOT being replaced by Cloudflare Workers.** This is a common misconception. The reality is:

- **Cloudflare Pages** remains the recommended platform for static websites
- **Cloudflare Workers** is for serverless functions and dynamic content
- Cloudflare Pages actually uses Workers under the hood for its infrastructure
- The modern best practice is to use **Wrangler CLI** (Cloudflare's official tool) for deployment

## What Changed

### Before: Third-party GitHub Action
```yaml
- name: Deploy to Cloudflare Pages
  uses: cloudflare/pages-action@1
  with:
    apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
    accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
    projectName: "personal-website"
    directory: "dist"
    gitHubToken: ${{ secrets.GITHUB_TOKEN }}
    branch: ${{ github.ref_name }}
```

### After: Official Wrangler CLI
```yaml
- name: Deploy to Cloudflare Pages
  env:
    CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}
    CLOUDFLARE_ACCOUNT_ID: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
  run: |
    npx wrangler pages deploy dist --project-name=personal-website --branch=${{ github.ref_name }}
```

## Benefits of Using Wrangler

1. **Official Support**: Wrangler is maintained by Cloudflare, ensuring better compatibility and updates
2. **More Features**: Direct access to all Cloudflare Pages features through CLI
3. **Better Control**: Fine-grained control over deployment options
4. **Future-Proof**: Aligned with Cloudflare's recommended deployment approach
5. **Local Testing**: Can test deployment locally before pushing to CI/CD

## Cost and Resilience

### Costs
- **Cloudflare Pages Free Tier**: 
  - Unlimited static requests
  - 500 builds per month
  - 20,000 files per site
  - No change in pricing with Wrangler

### Resilience
- Static files distributed across 200+ Cloudflare data centers globally
- 99.99%+ uptime SLA
- Automatic DDoS protection
- Edge caching for fast global delivery
- No change in resilience - same infrastructure

## Files Modified

1. **package.json**: Added `wrangler` as a dev dependency
2. **wrangler.toml**: Created Wrangler configuration file
3. **.github/workflows/build.yml**: Updated deployment step to use Wrangler CLI

## Local Deployment Testing

To test deployment locally (requires Cloudflare credentials):

```bash
# Set environment variables
export CLOUDFLARE_API_TOKEN=your_token
export CLOUDFLARE_ACCOUNT_ID=your_account_id

# Deploy to Pages
npx wrangler pages deploy dist --project-name=personal-website
```

## CI/CD Requirements

The GitHub Actions workflow requires these secrets to be configured:
- `CLOUDFLARE_API_TOKEN`: Your Cloudflare API token with Pages edit permissions
- `CLOUDFLARE_ACCOUNT_ID`: Your Cloudflare account ID

These are the same secrets used before, so no changes are needed.

## Additional Resources

- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [Wrangler CLI Documentation](https://developers.cloudflare.com/workers/wrangler/)
- [Cloudflare Pages Direct Upload Guide](https://developers.cloudflare.com/pages/how-to/use-direct-upload-with-continuous-integration/)
