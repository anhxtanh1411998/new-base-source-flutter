# Base Source Flutter

A complete Flutter base source with BLoC state management, multi-language support, and clean architecture.

## Overview

This project serves as a solid foundation for building Flutter applications following best practices and clean architecture principles. It provides a well-structured codebase with essential features already implemented, allowing developers to focus on building business logic rather than setting up project architecture.

## Features

- **Clean Architecture**: Organized in layers (data, domain, presentation) for better separation of concerns
- **BLoC State Management**: Using flutter_bloc for predictable state management
- **Dependency Injection**: Using get_it for service locator pattern
- **Multi-language Support**: Internationalization with support for English and Vietnamese
- **Theme Management**: Light and dark theme support with dynamic switching
- **Network Layer**: Dio HTTP client with interceptors and error handling
- **Error Handling**: Comprehensive error handling with custom exceptions and failures
- **Unit Testing**: Setup for testing with mockito and bloc_test

## Project Structure

```
lib/
├── core/                 # Core functionality used across the app
│   ├── di/               # Dependency injection
│   ├── error/            # Error handling
│   ├── localization/     # Internationalization
│   ├── network/          # Network related code
│   ├── theme/            # App themes
│   └── utils/            # Utility functions
├── data/                 # Data layer
│   ├── datasources/      # Remote and local data sources
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
├── domain/               # Domain layer
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Use cases
└── presentation/         # Presentation layer
    ├── blocs/            # BLoCs for state management
    ├── pages/            # App screens
    └── widgets/          # Reusable widgets
```

## Getting Started

### Prerequisites

- Flutter SDK (version 3.2.0 or higher)
- Dart SDK (version 3.2.0 or higher)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/anhxtanh1411998/new-base-source-flutter.git
   ```

2. Navigate to the project directory:
   ```
   cd new-base-source-flutter
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

## Using This Base Source for New Projects

### Method 1: Clone and Rename

1. Clone the repository:
   ```
   git clone https://github.com/anhxtanh1411998/new-base-source-flutter.git my_new_project
   ```

2. Navigate to the project directory:
   ```
   cd my_new_project
   ```

3. Remove the existing Git history:
   ```
   rm -rf .git
   ```

4. Initialize a new Git repository:
   ```
   git init
   ```

5. Update the project name in the following files:
   - `pubspec.yaml`: Change the name and description
   - `android/app/build.gradle`: Update applicationId
   - `android/app/src/main/AndroidManifest.xml`: Update package name
   - `ios/Runner.xcodeproj/project.pbxproj`: Update PRODUCT_BUNDLE_IDENTIFIER
   - `lib/main.dart`: Update app name

6. Install dependencies:
   ```
   flutter pub get
   ```

7. Run the app:
   ```
   flutter run
   ```

### Method 2: Use as a Template

1. Create a new Flutter project:
   ```
   flutter create --org com.yourcompany my_new_project
   ```

2. Copy the following directories from the base source to your new project:
   - `lib/core`
   - `lib/data`
   - `lib/domain`
   - `lib/presentation`
   - `assets`

3. Update your `pubspec.yaml` to include the same dependencies as the base source.

4. Update the `main.dart` file to initialize the dependency injection and run the app.

5. Run the app:
   ```
   flutter run
   ```

## Usage

### Adding a New Feature

1. Define entities in the domain layer
2. Create repository interfaces in the domain layer
3. Implement use cases in the domain layer
4. Create data models in the data layer
5. Implement repositories in the data layer
6. Create BLoCs in the presentation layer
7. Build UI components in the presentation layer

### Adding a New Language

1. Create a new JSON file in `assets/translations/` with the language code (e.g., `fr.json`)
2. Add the language to the supported locales in `lib/presentation/blocs/language/language_bloc.dart`

### Customizing Themes

Modify the theme data in `lib/core/theme/app_theme.dart` to match your app's design.

### Using Utility Classes

The project includes several utility classes to help with common tasks:

1. **DateUtil** (`lib/core/utils/date_utils.dart`):
   - Format dates
   - Parse date strings
   - Calculate date differences
   - Generate relative time strings

2. **StringUtil** (`lib/core/utils/string_utils.dart`):
   - Capitalize text
   - Truncate strings
   - Remove HTML tags
   - Validate emails and URLs
   - Convert between different case styles (camelCase, snake_case)

3. **ValidationUtil** (`lib/core/utils/validation_utils.dart`):
   - Validate required fields
   - Validate email formats
   - Validate password strength
   - Validate phone numbers
   - Validate URLs
   - Validate string lengths

4. **FileUtil** (`lib/core/utils/file_utils.dart`):
   - Get file extensions and names
   - Calculate file sizes
   - Determine file types (image, video, audio, document)
   - Download files from URLs
   - Create temporary files
   - Manage directories and file operations

## Testing

Run tests with:
```
flutter test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
