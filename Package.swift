// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "swift-graphql",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // SwiftGraphQL
        .library(name: "SwiftGraphQL", targets: ["SwiftGraphQL"]),
        .library(name: "SwiftGraphQLClient", targets: ["SwiftGraphQLClient"]),
        
        // Utilities
        .library(name: "GraphQL", targets: ["GraphQL"]),
        .library(name: "GraphQLAST", targets: ["GraphQLAST"]),
        .library(name: "GraphQLWebSocket", targets: ["GraphQLWebSocket"])
    ],
    dependencies: [
        // .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.5"),
    ],
    targets: [
        // Spec
        .target(name: "GraphQL", dependencies: [], path: "Sources/GraphQL"),
        .target(name: "GraphQLAST", dependencies: [], path: "Sources/GraphQLAST"),
        .target(
            name: "GraphQLWebSocket",
            dependencies: [
                "GraphQL",
                .product(name: "Logging", package: "swift-log"),
                "Starscream"
            ],
            path: "Sources/GraphQLWebSocket",
            exclude: ["README.md"]
        ),
        
        // SwiftGraphQL
        
        .target(
            name: "SwiftGraphQL",
            dependencies: ["GraphQL", "SwiftGraphQLUtils"],
            path: "Sources/SwiftGraphQL"
        ),
        .target(
            name: "SwiftGraphQLClient",
            dependencies: [
                "GraphQL",
                "GraphQLWebSocket",
                .product(name: "Logging", package: "swift-log"),
                "SwiftGraphQL",
            ],
            path: "Sources/SwiftGraphQLClient"
        ),
        .target(name: "SwiftGraphQLUtils", dependencies: [], path: "Sources/SwiftGraphQLUtils"),
        
        // Tests
        
        .testTarget(
            name: "SwiftGraphQLTests",
            dependencies: [
                "GraphQL",
                "GraphQLAST",
                "GraphQLWebSocket",
                "SwiftGraphQL",
                "SwiftGraphQLClient",
                "SwiftGraphQLUtils",
            ],
            path: "Tests",
            exclude: [
                "SwiftGraphQLCodegenTests"
            ]
        )
    ]
)
