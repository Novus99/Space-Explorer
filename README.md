# Space Explorer

Space Explorer is a native iOS application built with SwiftUI that allows users to explore the Solar System and browse NASA’s Astronomy Picture of the Day (APOD).

The project focuses on clean architecture, modern Swift concurrency, and production-ready UI patterns.

---

## Features

### Solar System

- Browse planets in the Solar System
- View detailed information about each planet
- Card-based, modern UI
- Dark mode support

### NASA APOD Integration

- Browse the last 30 Astronomy Pictures of the Day
- View a random APOD
- Skeleton loading animations
- Async image loading

---

## Tech Stack

- Swift 5
- SwiftUI
- MVVM architecture
- Swift Concurrency (async/await)
- URLSession
- AppStorage
- Custom skeleton loading implementation

---

## Architecture

The application follows the **MVVM pattern**:

```
Views
   ↓
ViewModels
   ↓
Services / Networking
```

### Architectural Principles

- Views are declarative and focus only on UI
- ViewModels manage state and business logic
- Networking is separated into dedicated services
- State is managed using `@StateObject` and `@Published`
- Async operations are handled using `async/await`

---

## APOD Loading Strategy

To ensure a smooth user experience:

- Skeleton views are displayed while data is loading
- Random image and list fetching run concurrently
- `AsyncImage` phase handling prevents UI flickering
- The UI never renders an empty screen

---

## Project Structure

```
Comming Soon

```
---

## Future Improvements

- Local caching
- Improved AR features
- Unit tests

---

## Requirements

- iOS 16+
- Xcode 15+

---

## Author

Created as a personal project focused on improving SwiftUI architecture, concurrency handling, and UI state management.
