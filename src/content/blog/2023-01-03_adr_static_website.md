---
title: "Building a Blog: ADR 1 – Static Website"
subheading: "This Website is Pretty Basic"
description: "The one in which I decide to build the blog as a static website."
pubDate: "2023-01-03"
tags:
  - blog
  - architecture
---

## Context

There are many ways to blog on the internet.
You could post articles to social platforms like LinkedIn.
You could post articles to platforms like Medium or Dev.to.
You could get your own website using services like Wordpress that provide hosting and complete themes for blogs.
Or you could build a website yourself.

### Goals and Principles

My top quality goals for this website are Performance Efficiency, Reliability, and Portability.[^1]

[^1]: [Building a Blog: Quality Goals](/blog/2023-01-02_quality_goals/)

### Make or "Buy"

Posting articles to platforms like LinkedIn, Medium, Dev.to, or managed Wordpress gives you reliabilty – no operations or maintenance effort necessary. But the platforms lack portability. You can't easily port the blog to another platform. You would have to copy & paste all articles.

Building a custom blog can achieve the performance, reliability, and portability goals – depending on how you build it.

### Static vs. Server-Rendered

You can build a custom blog as static website, where the HTML/CSS/JS/... files generated at build time, and then stored "on the web" in a CDN or S3-like storage. Or you can render the pages dynamically on a server (and optionally cache them).

Static websites can't render pages dynamically per user. But they bring some benefits [^2]:

+ **Security:** Immutable files without server or database access provide a minimum attack surface.
+ **Scalability:** Static websites can be served by a CDN, which can withstand even DDoS scenarios.
+ **Performance:** The markup and assets that the clients request are generated at build-time.
+ **Maintainability:** Serving static assets reduces operations effort to a minimum. This supports high availability.
+ **Portability:** You can host static files anywhere.

[^2]: [Why Jamstack?](https://jamstack.org/why-jamstack/)

## Decision

I will build the website as a static site.

A static site can achieve the top quality goals. Serving static files is fast and cheap. It requires minimum operations and maintenance work. It can be hosted anywhere.

## Consequences

A static website will be simple and durable. It will give me freedom for design and technology choices. It will allow me to play around with different technologies and techniques.

It takes some effort to design and build a website – significantly more than just posting articles to other platforms. However, it is easy to get started with: there are many templates for blogs that are quick and easy to set up. The design can come later.

A static website will not have the kind of virality of popular platforms.
When I publish an article to LinkedIn, I might get around two thousand impressions on people's feeds. By comparison, this blog will be read by virtually no one.
With a custom website, you can still cross-post the content to multiple platforms or just link to the website from platforms like LinkedIn. However, platforms like LinkedIn might not spread posts with outgoing links as widely.
