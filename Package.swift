import PackageDescription

let package = Package(
    name: "SwiftDIWebRepositories",
    dependencies: [
        .Package(url: "https://github.com/alexbasson/SwiftDIHLP.git", majorVersion: 0)
    ]
)
