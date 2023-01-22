---
layout: "../../layouts/BlogPost.astro"
title: "Diagrams as Code 2.0"
subheading: "With Structurizr by Simon Brown"
description: "The one in which I show you the best way to create architecture diagrams."
pubDate: "2023-01-22"
tags:
  - architecture
---

## Diagrams as Code 2.0

> * Diagrams as code 1.0: you write diagram definitions by hand
> * Diagrams as code 2.0: diagram definitions are generated automatically, by tooling, based upon views of a model
> — <cite>Simon Brown[^1]</cite>

[^1]: Simon Brown [Diagrams as code 2.0](https://dev.to/simonbrown/diagrams-as-code-2-0-82k)

Generating architecture diagrams from code allows you to keep the diagrams co-located with the code and version control them like the code. This is called “diagrams as code”[^2]

[^2]: Thoughtworks Technology Radar [Diagrams as code](https://www.thoughtworks.com/radar/techniques/diagrams-as-code)

PlantUML is a classic tool that renders diagrams from a domain-specific language.
With PlantUML you specify each diagram independently.
If you document a system with a set of PlantUML diagrams and change its architecture,
you may have to update multiple diagrams and keep them in-sync.
For example, the following snipped specifies a basic sequence diagram with a request and a response:[^3]

[^3]: plantuml.com [Sequence Diagram](https://plantuml.com/sequence-diagram)

```plantUML
@startuml
Client -> Server: Authentication Request
Server --> Client: Authentication Response
@enduml
```

“Diagrams as code 2.0” – coined by Simon Brown – improves on the concept.
You model your system as a whole and then generate multiple diagrams from the model. That way, the diagrams stay consistent and in-sync.[^4],[^5]

[^4]: Simon Brown [Diagrams as code 2.0](https://dev.to/simonbrown/diagrams-as-code-2-0-82k)
[^5]: Simon Brown, GOTO 2021 [Diagrams as code 2.0](https://www.youtube.com/watch?v=Za1-v4Zkq5E)

## Structurizr DSL

Structurizr[^6] by Simon Brown comprises a set of tools to generate [C4 Model diagrams](/blog/2023-01-21_c4_model_diagrams/) as code.

[^6]: Simon Brown, structurizr.com [Structurizr](https://structurizr.com)

The Structurizr DSL allows you to model a system with a domain-specific language. You can then specify different views of the system to generate multiple diagrams from the model.[^7]

[^7]: Simon Brown [Structurizr DSL](https://github.com/structurizr/dsl)

The Structurizr CLI allows you to generate diagrams from the Structurizr DSL.  
It supports a number of ouptut formats including PlantUML and Mermaid.[^8]

[^8]: Simon Brown [Structurizr CLI](https://github.com/structurizr/cli)

### Example for this Blog

The following code block contains a model for the architecture of this blog using Structurizr DSL. The snippet specifies both a system context view and a container view based on the model.

```
workspace "Website" {
    name "Website"
    description "The software architecture of the website."

    # the model of the system
    model {
        # the users of the system
        reader = person "Hypothetical reader" "A hypothetical reader of the blog" "Reader"
        philip = person "Philip" "Philip" "Editor"

        # the system
        website = softwaresystem "Website" "Allows readers to read blog posts." {
            # the containers within the system
            staticFiles = container "Static Files" "Static files for all pages" "HTML/CSS/JS"
            staticFilesHost = container "Static Files Host" "Serves static files to clients" "HTTPS"
        }

        # relationships to/from system
        reader -> website "Hypothetically reads blog post on website."
        philip -> website "Writes blog posts (in theory, from time to time)"

        # relationships to/from containers
        reader -> staticFilesHost "Visits philip-schmitt.de using" "HTTPS"
        staticFilesHost -> staticFiles "Delivers to the customer's web browser"
    }

    # the views to generate from the model
    views {
        systemcontext website "SystemContext" {
            include *
        }

        container website "Containers" {
            include *
        }
    }
}
```

We can use Structurizr CLI to generate PlantUML diagrams from the Structurizr DSL, and then use PlantUML to render the diagrams.

```sh
#Generate plantUML diagrams from structurizr
docker run --rm \
-v "${PWD}":/root/data -w /root/data \
structurizr/cli:latest \
export -f plantuml/c4plantuml -w "workspace.dsl"
# Render plantUML diagrams
docker run --rm \
-v "${PWD}":/root/data -w /root/data \
plantuml/plantuml -tsvg "*.puml"
```

This results in the following diagrams:

![System context diagram of this blog: a hypothetical reader reads blog posts on the website, while I write blog posts from time to time.](/c4-website-context.svg#centered)

![Container diagram of this blog: static files (HTML, CSS, JS) served from static files host via HTTPS.](/c4-website-containers.svg#centered)

For more information on and examples from Structurizr, see [structurizr.com](https://structurizr.com) and [github.com/structurizr](https://github.com/structurizr)
