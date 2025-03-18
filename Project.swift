import ProjectDescription

let project = Project(
    name: "JourneyBook",
    settings: .settings(
            base: [
                "DEVELOPMENT_TEAM": "75ESF57BMG",
            ]
        ),
    targets: [
        .target(
            name: "JourneyBook",
            destinations: .iOS,
            product: .app,
            bundleId: "co.jackdelaney.jb",
            deploymentTargets: .iOS("18.2"),
            infoPlist: .extendingDefault(
                with: [
                    "LSApplicationCategoryType": "public.app-category.productivity",
                    "ITSAppUsesNonExemptEncryption": "false",
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UISupportsFullScreenInAssistiveAccess" : "true",
                    "NSLocationWhenInUseUsageDescription": "The app needs access to your location to provide location-based services.",
                    "LSApplicationQueriesSchemes": [
                        "Item 0": "maps",
                        "Item 1": "waze",
                        "Item 2": "comgooglemaps",
                    ],
                ]
            ),
            sources: ["JourneyBook/Sources/**"],
            resources: ["JourneyBook/Resources/**"],
            dependencies: [
                .external(name: "FeedKit"),
                .target(name:"JourneyBookWidgetExtension"),
                .external(name: "PostHog")
            ]
        ),
        .target(
            name: "JourneyBookWidgetExtension",
            destinations: .iOS,
            product: .appExtension,
            bundleId: "co.jackdelaney.jb.JourneyBookWidgetExtension",
            deploymentTargets: .iOS("18.2"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(PRODUCT_NAME)",
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widgetkit-extension",
                ],
            ]),

            sources: ["JourneyBook/JourneyBookWidgetExtension/**"],
            resources: ["JourneyBook/JourneyBookWidgetExtensionResources/**"],
            dependencies: [
                .external(name: "FeedKit"),
            ]

        ),
        .target(
            name: "JourneyBookTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "co.jackdelaney.jbTests",
            deploymentTargets: .iOS("18.2"),
            infoPlist: .extendingDefault(with: ["NSExtensionPointIdentifier": "com.apple.widgetkit-extension"]),
            sources: ["JourneyBook/Tests/**"],
            resources: [],
            dependencies: [.target(name: "JourneyBook")]
        ),
    ]
)
