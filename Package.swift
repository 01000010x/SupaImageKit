// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SupaImageKit",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "SupaImageKit", targets: ["SupaImageKit"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/supabase/supabase-swift.git",
            .upToNextMajor(from: "2.27.0")
        )
    ],
    targets: [
        .target(
            name: "SupaImageKit",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift")
            ]
        )
    ]
)
