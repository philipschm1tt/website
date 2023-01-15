workspace "Website" {
    name "Website"
    description "The software architecture of the website."

    model {
        reader = person "Hypothetical reader" "A hypothetical reader of the blog" "Reader"
        philip = person "Philip" "Philip" "Editor"

        website = softwaresystem "Website" "Allows readers to read blog posts." {
            staticFiles = container "Static Files" "Static files for all pages" "HTML/CSS/JS"
            staticFilesHost = container "Static Files Host" "Serves static files to clients" "HTTPS"
        }

        reader -> website "Hypothetically reads blog post on website."
        philip -> website "Writes blog posts (in theory, from time to time)"

        # relationships to/from containers
        reader -> staticFilesHost "Visits philip-schmitt.de using" "HTTPS"
        staticFilesHost -> staticFiles "Delivers to the customer's web browser"

        deploymentEnvironment "Live" {
            deploymentNode "Reader's computer" "" "Microsoft Windows or Apple macOS" {
                deploymentNode "Web Browser" "" "Chrome, Firefox, Safari, or Edge" {
                    liveStaticFilesInstance = containerInstance staticFiles
                }
            }

            deploymentNode "Cloudflare" "" "Cloudflare data center" {
                deploymentNode "Cloudflare Pages" "" "" "" 1 {
                    liveStaticFilesHostInstance = containerInstance staticFilesHost
                }
            }
        }
    }

    views {
        systemcontext website "SystemContext" {
            include *
            animation {
                website
                reader
            }
        }

        container website "Containers" {
            include *
            animation {
                reader
                staticFiles
                staticFilesHost
            }
        }

        deployment website "Live" "LiveDeployment" {
            include *
            animation {
                liveStaticFilesInstance
                liveStaticFilesHostInstance
            }
        }

        styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "Reader" {
                background #08427b
            }
            element "Editor" {
                background #999999
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Failover" {
                opacity 25
            }
        }
    }

}
