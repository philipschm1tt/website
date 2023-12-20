---
title: "Building a Blog: ADR 2 – Content in Git"
subheading: "Markdown is Fine"
description: "The one in which I decide between markdown and CMS-as-a-service."
pubDate: "2023-01-04"
tags:
  - blog
  - architecture
---

## Context

I will build this blog as a static website[^1].
Blog posts require formatted text content and assets like images.
That content has to be stored somewhere.

[^1]: [Building a Blog: ADR 1 – Static Website](/blog/2023-01-03_adr_static_website/)

The simplest approach is to store content and assets directly in the repository.
Text can be stored in Markdown files. Images can be stored in an assets folder.
Editors like Visual Studio Code can show a preview of the content of Markdown files.
For a single editor, who is used to git and who can preview the full site on their local machine, this works.
Github repository limits are generous enough that small images that accompany articles should not pose a problem[^2]. Largers assets could be stored in some S3-like storage service.

- ✅ Service-agnostic: Markdown is a standard format
- ✅ Avoid 3rd party service: does not depend on existance and pricing of service provider
- ❌ Content in repository: can clutter up and enlarge repository with assets; assets in public repository?
- ❌ Requires technical expertise: Markdown and git are required to edit content

[^2]: Stackoverflow [Repository size limits for GitHub.com](https://stackoverflow.com/a/59479166)

On the other end of the spectrum, you can use a CMS-as-a-service from providers like Storyblok, Contentful, and others.
They provide editing and publishing features on the web.
When content changes, a web hook triggers a build. The build process gets the updated content from the API of the service.
The services facilitate content management with multiple editors (including rights management and configurable publishing processes).
The services typically support image content and other assets. They typically provide a CDN to serve the assets to clients.
By focusing on integration via their APIs, the services work well for static websites.

- ✅ Best editing experience: services provide elaborate UI
- ✅ Content and assets separate from code: repository stays lean and assets don't end up in public repository
- ✅ Support large assets: services are built for managing and serving large assets
- ❌ Dependency on service provider: service provider may go out of business or change their pricing/plans
- ❌ Non-standard format: service may store text content in a proprietary format that can't easily be ported to another service

Between the two extremes, there are git-based CMS solutions like [Tina](https://tina.io/). They can provide an editing experience comparable to the CMS-as-a-service approach. But all content stays in git.

- ✅ Good editing experience: can (theoretically) provide editing capabilities comparable to CMS services
- ✅ Service-agnostic: Markdown is a standard format
- ✅ Avoid 3rd party service: does not depend on existance and pricing of service provider
- ❌ Content in repository: can clutter up and enlarge repository with assets; assets in public repository?

## Decision

I will store content and assets directly in the git repository using Markdown for text content.

One of the architecture principles of the website is "built to last". Using standard formats and avoiding a 3rd party service supports that.

I don't expect to create so much content (and use so many assets) that github repository limits would become limiting.

I will experiment with a git-based CMS solution that relies on Markdown. I don't expect any benefits for my use case, but I would like to gain experience with git-based CMS solutions.

## Consequences

Relying on the standard markdown format and avoiding a 3rd party service supports the architecture goals of this website.
It should be built to last and portable to other providers.

Experimenting with git-based CMS solutions will allow me to use the website as playground for learning.

Keeping the assets in the repository could become cumbersome.
In rare cases, I might want larger assets like audio or video files. I would not want to add them to the git repository but use another storage option like an S3-like service instead. Therefore, I might not treat all assets the same way – adding some inconsistency.
