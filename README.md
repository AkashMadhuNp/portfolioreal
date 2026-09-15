# Akash Madhu N P - Flutter Portfolio

A modern, responsive, and performance-optimized Flutter Web portfolio built with Clean Architecture principles.

## Architecture & Design Patterns

This project has been architected to demonstrate senior-level engineering practices while avoiding over-engineering:

### Why Provider?
We consciously chose **Provider** over Riverpod or BLoC. For a portfolio with primarily static data and simple state requirements (theme toggling, scrolling, form submission), Provider offers the perfect balance of simplicity, readability, and performance. Introducing more complex state management solutions would violate the YAGNI (You Aren't Gonna Need It) principle.

### Why Static Data instead of a CMS?
The portfolio content (Projects, Experience, Skills) is statically defined in models rather than fetched from a headless CMS (like Sanity or Firebase Firestore).
- **Reliability:** The portfolio will always load instantly without depending on third-party APIs.
- **Cost:** Zero backend infrastructure costs.
- **Performance:** No network latency for content rendering.

### Dependency Injection
Dependencies are managed using **Constructor Injection** rather than Service Locators (like `get_it`). 
For example, the `ContactProvider` depends on an abstract `MessageRepository`. In production, a `FirebaseMessageRepository` is injected, which encapsulates Firestore and EmailJS logic.
This makes the `ContactProvider` fully unit-testable using a `FakeMessageRepository` without needing any external mock packages.

### Error Handling
A centralized `AppLogger` is used instead of scattered `print` statements. 
Global error boundaries (`FlutterError.onError` and `PlatformDispatcher.instance.onError`) are established in `main.dart` to catch and log framework and asynchronous errors gracefully.

### Accessibility
Interactive UI elements (Project Cards, Skill Chips, Social Links) are wrapped in `Semantics` widgets to ensure they are accessible to screen readers, providing clear context and button labels.

### CI/CD
A GitHub Actions workflow (`.github/workflows/deploy.yml`) is implemented with strict quality gates:
1. `flutter analyze` (Must pass, no bypasses)
2. `flutter test` (Unit tests must pass)
3. `flutter build web --release`

## Project Structure

```text
lib/
├── core/             # App-wide constants, theme, and utility services (Logger, Firebase config)
├── data/             # Concrete implementations (FirebaseMessageRepository) and static models
├── domain/           # Business logic interfaces (MessageRepository, Entities)
├── presentation/     # UI layer (Screens, Sections, Widgets, Providers)
└── main.dart         # Entry point and Dependency wiring
```

## Running the Project

```bash
# Get dependencies
flutter pub get

# Run formatting and analysis
flutter format .
flutter analyze

# Run unit tests
flutter test

# Run on web
flutter run -d web
```
