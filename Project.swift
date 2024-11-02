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
          "NSPhotoLibraryUsageDescription": "We want to save photos to your photo library",
        ]
      ),
      sources: ["JourneyBook/Sources/**"],
      resources: ["JourneyBook/Resources/**"],
      dependencies: []
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
  ],
  schemes: [
    .scheme(
        name: "JourneyBook",
        buildAction: .buildAction(targets: ["JourneyBook"]),
        testAction: nil,
        archiveAction: .archiveAction(configuration: "Debug")
    )
]
)


