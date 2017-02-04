import PackageDescription

let package = Package(
    name: "SwiftDIWebRepositories",
    dependencies: [
        .Package(url: "../SwiftDIHLP", majorVersion: 0)
    ]
)
