import ProjectDescription

let project = Project(
    name: "JourneyBook",
    options: .options(
        automaticSchemesOptions: .enabled(
            codeCoverageEnabled: true
        )),
    settings: .settings(
        base: [
            "DEVELOPMENT_TEAM": "75ESF57BMG",
        ]
    ),
    targets: [
        .target(name: "AppExtensionJBKit",
                destinations: .iOS,
                product: .framework,
                bundleId: "co.jackdelaney.jb.appExtensionTestableCode",
                sources: ["AppExtensionTestableCode/**"],
                dependencies: [
                    .external(name: "FeedKit"),
                    .target(name: "SharedPersistenceKit"),
                    .target(name: "CommonCodeKit"),
                ]),
        .target(name: "SharedPersistenceKit",
                destinations: .iOS,
                product: .framework,
                bundleId: "co.jackdelaney.jb.sharedDataCode",
                deploymentTargets: .iOS("18.4"),
                sources: ["Persistence/**"]),
        .target(name: "CommonCodeKit",
                destinations: .iOS,
                product: .framework,
                bundleId: "co.jackdelaney.jb.sharedCode",
                deploymentTargets: .iOS("18.4"),
                sources: ["Shared/**"],
                dependencies: [
                    .target(name: "SharedPersistenceKit"),
                ]),
        .target(
            name: "JourneyBook",
            destinations: .iOS,
            product: .app,
            bundleId: "co.jackdelaney.jb",
            deploymentTargets: .iOS("18.4"),
            infoPlist: .extendingDefault(
                with: [
                    "LSApplicationCategoryType": "public.app-category.productivity",
                    "ITSAppUsesNonExemptEncryption": "false",
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UISupportsFullScreenInAssistiveAccess": "true",
                    "NSLocationWhenInUseUsageDescription": "The app needs access to your location to provide location-based services.",
                    "LSApplicationQueriesSchemes": [
                        "Item 0": "maps",
                        "Item 1": "waze",
                        "Item 2": "comgooglemaps",
                    ],
                    "NSSupportsLiveActivities": "true",
                    "CFBundleDisplayName": "JourneyBook",
                    "CFBundleURLTypes": [
                        [
                            "CFBundleURLName": "co.jackdelaney.jb",
                            "CFBundleURLSchemes": ["journeybookjourney"],
                        ],
                    ],
                ]
            ),
            sources: ["JourneyBook/Sources/**"],
            resources: ["JourneyBook/Resources/**"],
            entitlements: "JourneyBook/JourneyBook.entitlements",
            dependencies: [
                .external(name: "FeedKit"),
                .target(name: "CommonCodeKit"),
                .target(name: "SharedPersistenceKit"),
                .target(name: "JourneyBookWidgetExtension"),
                .external(name: "PostHog"),
            ]
        ),
        .target(
            name: "JourneyBookWidgetExtension",
            destinations: .iOS,
            product: .appExtension,
            bundleId: "co.jackdelaney.jb.JourneyBookWidgetExtension",
            deploymentTargets: .iOS("18.4"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(PRODUCT_NAME)",
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widgetkit-extension",
                ],
            ]),

            sources: ["JourneyBookWidgetExtension/**"],
            resources: ["JourneyBookWidgetExtensionResources/**"],
            entitlements: "JourneyBookWidgetExtension/JourneyBookWidgetExtension.entitlements",
            dependencies: [
                .target(name: "AppExtensionJBKit"),
                .target(name: "CommonCodeKit"),
            ]

        ),
        .target(
            name: "JourneyBookTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "co.jackdelaney.jbTests",
            deploymentTargets: .iOS("18.4"),
            infoPlist: .extendingDefault(with: ["NSExtensionPointIdentifier": "com.apple.widgetkit-extension"]),
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "JourneyBook"),
                .target(name: "AppExtensionJBKit"),
                .target(name: "CommonCodeKit"),
            ]
        ),
        .target(name: "JourneyBookTestsUI",
                destinations: .iOS,
                product: .uiTests,
                bundleId: "co.jackdelaney.jbTestsUI",
                deploymentTargets: .iOS("18.4"),
                infoPlist: .extendingDefault(with: ["NSExtensionPointIdentifier": "com.apple.widgetkit-extension"]),
                sources: ["TestsUI/**"],
                resources: [],
                dependencies: [.target(name: "JourneyBook")]),
    ]
)
