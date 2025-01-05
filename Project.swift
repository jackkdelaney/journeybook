import ProjectDescription

let project = Project(
  name: "JourneyBook",
  targets: [
    .target(
      name: "JourneyBook",
      destinations: .iOS,
      product: .app,
      bundleId: "co.jackdelaney.jb",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "NSLocationWhenInUseUsageDescription": "The app needs access to your location to provide location-based services.",
          "LSApplicationQueriesSchemes": [
            "Item 0" : "maps",
            "Item 1" : "waze",
            "Item 2" : "comgooglemaps",
          ]
        ]
      ),
      sources: ["JourneyBook/Sources/**"],
      resources: ["JourneyBook/Resources/**"],
      dependencies: [
        .external(name: "FeedKit")
      ]
    ),
    .target(
      name: "JourneyBookTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "co.jackdelaney.jbTests",
      infoPlist: .default,
      sources: ["JourneyBook/Tests/**"],
      resources: [],
      dependencies: [.target(name: "JourneyBook")]
    ),
  ]
)


