// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CharacterList",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CharacterList",
            targets: ["CharacterList"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Shared"),
        .package(path: "../RickAndMortyRestAPI"),
        .package(path: "../FavoriteCharacters"),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.8.1"),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CharacterList",
            dependencies: ["Shared", "RickAndMortyRestAPI", "FavoriteCharacters"]),
        .testTarget(
            name: "CharacterListTests",
            dependencies: ["CharacterList", "SnapshotTesting"]),
    ]
)
