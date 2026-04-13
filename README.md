# Exercise

This sample app is a small iOS application with two user flows:

- An `About` screen built with `UIKit`
- A `TO-DO` list built with `SwiftUI`

It uses a hybrid approach where UIKit drives the app shell and navigation, while SwiftUI handles the reactive list UI.

## Technology Used

### UIKit

`UIKit` is used for the application lifecycle and navigation structure.

It is responsible for:

- App launch through `AppDelegate`
- Window setup
- Navigation controllers
- The root screen in `ViewController`
- The `AboutViewController`

This keeps the app flow explicit and works well with the coordinator pattern used in the project.

### SwiftUI

The TO-DO feature UI is implemented in `TodoListScreen.swift` using `SwiftUI`.

SwiftUI is used for:

- Rendering the todo list
- Reacting automatically to state changes
- Displaying per-row UI states like loading, success, and failure

The SwiftUI screen is presented from UIKit using `UIHostingController`, which makes the integration between both frameworks straightforward.

### Swift Concurrency

The app uses Swift concurrency with `Task` and `async/await`.

This is mainly used in `TodoListViewModel` to simulate an asynchronous save operation:

- A task is inserted immediately with a `saving` state
- A random delay simulates network latency
- The save randomly succeeds or fails
- Failed items are removed after a short delay

This keeps async code simple and readable.

### Observable State

`TodoListViewModel` conforms to `ObservableObject` and exposes `@Published` state.

That enables:

- `SwiftUI` to refresh the todo list automatically when items change
- `UIKit` to observe the todo count and update the home screen button title

`AppCoordinator` listens to the view model's published `items` count and pushes updates into the root `ViewController`.

### Testing

The project includes unit tests in `ExerciseTests/TodoListViewModelTests.swift`.

The tests cover the main behavior of the todo feature:

- Input trimming
- Empty-input rejection
- Successful save transitions
- Failed-save removal
- Deletion rules

The test target uses Apple's `Testing` framework.

## Architecture

The project follows a simple **Coordinator + MVVM-style** structure.

### Coordinator Pattern

Navigation is managed by dedicated coordinator types instead of being embedded directly in view controllers.

Main coordinators:

- `AppCoordinator`
- `AboutCoordinator`
- `TodoCoordinator`

Responsibilities:

- `AppCoordinator` starts the app and owns the root navigation flow
- `AboutCoordinator` handles the About screen presentation lifecycle
- `TodoCoordinator` pushes the todo feature and presents the add-task alert

This improves separation of concerns and keeps navigation logic centralized.

### MVVM in the TO-DO Feature

The TO-DO flow is the clearest MVVM example in the app.

- `Model`: `TodoItem`, `TodoItemStatus`
- `ViewModel`: `TodoListViewModel`
- `View`: `TodoListScreen`

`TodoListViewModel` owns the business logic and mutable state for the list. `TodoListScreen` is responsible only for rendering that state and forwarding user actions like delete.

### Thin View Controllers

The UIKit view controllers are intentionally light:

- `ViewController` displays buttons and forwards taps via closures
- `AboutViewController` handles only screen setup and the close action

This keeps them focused on presentation rather than app flow or business logic.

## Project Structure

```text
Exercise
├── App
│   ├── AppDelegate.swift
│   ├── AppCoordinator.swift
│   ├── Coordinator.swift
│   └── ViewController.swift
├── About
│   ├── AboutCoordinator.swift
│   └── AboutViewController.swift
├── TodoList
│   ├── TodoCoordinator.swift
│   ├── TodoItem.swift
│   ├── TodoItemStatus.swift
│   ├── TodoListScreen.swift
│   └── TodoListViewModel.swift
└── ExerciseTests
    └── TodoListViewModelTests.swift
```

## Summary

This codebase uses:

- `UIKit` for app lifecycle and navigation
- `SwiftUI` for the reactive todo list screen
- Swift concurrency for async state transitions
- A coordinator pattern for navigation
- An MVVM-style feature structure for the todo flow

For a small sample app, this is a clean architecture: navigation is isolated, UI code stays relatively thin, and the most important behavior is covered by tests.
