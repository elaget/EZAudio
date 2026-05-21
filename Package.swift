// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "EZAudio",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "EZAudio",
            targets: ["EZAudio"]
        ),
    ],
    targets: [
        .target(
            name: "EZAudio",
            // path raíz para poder declarar exclude del .xcodeproj, examples, etc.
            path: ".",
            exclude: [
                "EZAudioExamples",
                "EZAudio.xcodeproj",
                "EZAudio.podspec",
                "README.md",
                "LICENSE",
                "EZAudio/Info.plist",
                // Umbrella OSX (no aplica a iOS)
                "EZAudio/EZAudioOSX.h",
                // Umbrella alternativo iOS framework-style (excluido también en podspec)
                "EZAudio/EZAudioiOS.h",
            ],
            sources: ["EZAudio"],
            // TPCircularBuffer.{h,c} se embebe en el target (el podspec lo excluía
            // y dependía del pod externo 'TPCircularBuffer'; en SPM lo compilamos
            // junto con EZAudio). La API pública de EZAudio.h usa TPCircularBuffer*,
            // así que el consumer lo necesita disponible.
            publicHeadersPath: "EZAudio",
            linkerSettings: [
                .linkedFramework("AudioToolbox"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("GLKit"),
                .linkedFramework("Accelerate"),
            ]
        ),
    ]
)
