# KernelDirectoryUI

A library to display the apps in the Kernel Project.

Implementing it into your app is one of the requriements to have your application listed.

### Guidelines
 - The featured apps view should be added to the root page of your Settings or Info screen.
 - It should be positioned in a way where at least the first app on the list is visible without scrolling on an iPhone X-sized screen.

These guidelines exist to make sure that all apps that benefit from being listed are playing their part.

## Instructions

Add this repository to your project as a dependency. [Instructions](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).
Import the module by using `import KernelDirectoryUI`

### The Client
Instantiate the client with the AppStore ID of your application. Only include the numbers.
It's not necessary to persist the client throughout the life of your application, but it should at least persist through the life of your Settings screen.

```swift
let client = KernelClient(appId: "1558429748")
```

### Featured Apps View

#### SwiftUI

Instantiate `DirectoryFeaturedView` by passing the client and a style (optional) and include it in your view hierarchy.

```swift
DirectoryFeaturedView(client: client) { }
	.padding()
```

#### UIKit

Instantiate `DirectoryFeaturedAppsView` by passing the client, a style (optional), and the presenting view controller and add it to your view hierarchy.

```swift
let view = DirectoryFeaturedAppsView(client: client, presentingController: self)
stackView.addArrangedSubview(view)
```

### Style

Two styles are included in `KernelDirectoryStyle`:

- `default` is designed to be displayed on a view with `primaryBackground` as a background color.
- `groupedList` is designed to be displayed in a grouped list table view. You can display the title as the section title using `DirectoryFeaturedView.title`.

Custom styles can be created by creating a new struct of `KernelDirectoryStyle`. The `UIKitColors` struct and property is only required when using UIKit.

## All Apps List - Work in Progress
The featured list will include a button that will allow users to view all the applications in the project.

You should use the trailing closure of `DirectoryFeaturedView` or `DirectoryFeaturedAppsView` to display the list depending on how your view is setup.

### SwiftUI

#### Display in a NavigationView

`DirectoryListView` view can be used as the content of a `NavigationLink` to display the list in a `NavigationView`.

#### Display as a Modal

`DirectoryModalView` wraps `DirectoryListView` in a `NavigationView` with a close button, making it easy to present modally.

### UIKit

#### Display in a UINavigationController

`DirectoryListViewController` can be pushed into the stack of a navigation controller.

#### Display as a Modal

`DirectoryListModalController` is a `UINavigationController` subclass containing a `DirectoryListViewController`, which can be used to present modally.

# Done!
