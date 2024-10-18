import ProjectDescription

let project = Project(
  name: "Project301",
  targets: [
    .target(
      name: "Project301",
      destinations: .iOS,
      product: .app,
      bundleId: "co.jackdelaney.p301",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "NSPhotoLibraryUsageDescription": "We want to save photos to your photo library",
        ]
      ),
      sources: ["project-p301/Sources/**"],
      resources: ["project-p301/Resources/**"],
      dependencies: []
    ),
    .target(
      name: "Project301Tests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "co.jackdelaney.p301Tests",
      infoPlist: .default,
      sources: ["project-p301/Tests/**"],
      resources: [],
      dependencies: [.target(name: "Project301")]
    ),
  ]
)
