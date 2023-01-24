---
title: "Building a Blog: ADR 3 – Astro on Cloudflare"
subheading: "\"New is always better\""
description: "The one in which I decide to build this website with Astro and host it on Cloudflare Pages."
pubDate: "2023-01-05"
tags:
  - blog
  - architecture
---

## Context

### Static Site Generators

There are many Static Site Generators (SSGs) and, more generally, meta frameworks that can generate static sites[^1].

[^1]: jamstack.org [Site Generators](https://jamstack.org/generators/)

Popular classic site generators include Eleventy, Jekyll, and Hugo.
They specialize on static sites.
Over the past few years, SSG has become a common feature of most meta frameworks.
They include Next, Nuxt, SvelteKit, SolidStart, Qwik City, and more. Most meta frameworks are built for a specific component framework.
Astro, on the other hand, supports a number of popular component frameworks. It started out as a Static Site Generator and was later extended to also support server-side rendering.

### Single-Page Application vs. Multi-Page Application

A key difference between the Static Site Generators is whether they produce Single-Page Applications (SPAs) or Multi-Page Applications (MPAs).

SPAs can achieve an app-like user experience with quick navigation between pages. However, that comes at a cost. They tend to use significantly more JavaScript, which reduces first page load performance. SPAs also present some additional challenges for accessibility due to their client-side navigation. [^2]

Frameworks like Astro and Qwik City have overcome some of the biggest challenges of the MPA architecture. They enable a more seamless developer experience between the static parts of a website and the interactive parts.

For more details on current developments on the spectrum between Multi-Page Applications and Single-Page Applications, see my talk[^3] or article[^4].

[^2]: Rich Harris, Jamstack Conf 2021, [Have Single-Page Apps Ruined the Web?](https://www.youtube.com/watch?v=860d8usGC0o)
[^3]: Philip Schmitt, Big Techday 2022, [The Future of the Frontend](https://www.youtube.com/watch?v=etbyN1zyY1Ma)
[^4]: Philip Schmitt, dotnetpro 12/2022, [Die Zukunft des Frontends](https://www.dotnetpro.de/frontend/zukunft-frontends-2810967.html)

### Hosting Static Websites

There are many platforms for hosting static websites.
Popular examples are Netlify, Vercel, Cloudflare Pages, Azure Static Web Apps.
They provide similar capabilities and are easy and cheap to use – with generous free plans.

Most platforms for static websites provide Github integration, where commits trigger new builds. Branches may automatically be deployed to a preview environment / URL.
The platforms can manage custom domains and provide SSL certificates automatically.
Some platforms differentiate themselves through integrations with other services like data stores or server-side analytics.

For basic hosting of static websites the different platforms appear similar and it should be easy to move a website between different platforms.

### Goals and Principles

My top quality goals for this website are Performance Efficiency, Reliability, and Portability.[^5]

[^5]: [Building a Blog: Quality Goals](/blog/2023-01-02_quality_goals/)

## Decision

I will build the website with Astro and host it on Cloudflare Pages.

Astro is a part of the recent renaissance of Multi-Page Applications.
It enables creating lightweight pages with little JavaScript and fast first page load performance. This is in line with the quality goals of this website.

Another benefit of Astro is that it does not lock you into one component framework.
It supports a number of the most popular frameworks.
Being able to experiment with different frameworks supports my goal of using this website as a playground for learning.
The increasing popularity of Astro also makes Astro experience valuable.

Cloudflare is one of the leaders in the area of edge computing.
With their leading CDN and their growing list of edge services like Cloudflare Workers and various edge data stores, they provide a lot of opportunities for learning.

Cloudflare offer Cloudflare Pages[^6] with a generous free plan[^7].
That includes free web analytics and unlimited sites/requests/bandwidth.
As long as you don't need more than 500 builds per month or concurrent builds, this is enough. Besides hosting static websites, Pages also provides integrations with other Cloudflare services like Workers. It also enables server-side rendering "on the edge".[^8],[^9]

[^6]: Cloudflare [Pages](https://www.cloudflare.com/products/pages/)
[^7]: Cloudflare [Developer Platform Pricing](https://www.cloudflare.com/plans/developer-platform-pricing/)
[^8]: Cloudflare Blog [Cloudflare Pages is now Generally Available](https://blog.cloudflare.com/cloudflare-pages-ga/)
[^9]: Cloudflare Blog [Cloudflare Pages Goes Full Stack](https://blog.cloudflare.com/cloudflare-pages-goes-full-stack/)

## Consequences

Astro supports the goals for performance and portability. It will not lock me into a specific component framework and will produce fast pages with little JavaScript.

By working with with a popular, trendy framework and a popular leading platforms, I will have ample opportunity to experiment with interesting technologies and gain valuable experience.

There may be some tension between the goal of portability and treating the website as a playground for learning.
While it is trivial to move basic static websites between different hosting platforms, integrating platforms-specific features like edge data stores could reduce portability.
