import PackageDescription

let package = Package(
	name: "messages",
	dependencies: [
			.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
			.Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 1)
	],
	exclude: [
		"Config",
		"Database",
		"Localization",
		"Public",
		"Resources",
	]
)

