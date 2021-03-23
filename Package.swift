// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "KernelDirectoryUI",
	platforms: [
		.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)
	],
	products: [
		.library(
			name: "KernelDirectoryUI",
			targets: ["KernelDirectoryUI"]),
	],
	dependencies: [
		.package(url: "https://github.com/EmilioPelaez/RESTClient", "0.9.0"..<"1.0.0")
	],
	targets: [
		.target(
			name: "KernelDirectoryUI",
			dependencies: ["RESTClient"],
			resources: [
				.process("TestData"),
			]),
		.testTarget(
			name: "KernelDirectoryUITests",
			dependencies: ["KernelDirectoryUI"],
			resources: [
				.process("TestData"),
			]),
	]
)
