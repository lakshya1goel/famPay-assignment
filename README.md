# FamPay Contextual Cards Assignment

A Flutter application that displays dynamic contextual cards fetched from an API. Built with clean architecture, BLoC pattern for state management, and features a plug-and-play card container component.

## 📱 Demo

### APK
[APK link](https://drive.google.com/file/d/1cdLie4pXS5K0nvkVK57bTc_wamFja_71/view?usp=sharing)

### 📹 Video Demo
[Watch the demo](https://drive.google.com/file/d/1dN8Fhj325w7e3AuNtwVNRMtQ-v22mmQR/view?usp=sharing)

### 📸 Screenshots

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/8f2e3b4f-f111-4b73-89b3-40411a4f5299" width="250" alt="Image"/></td>
    <td><img src="https://github.com/user-attachments/assets/1bf4cedf-b03d-4830-93d7-a62c4702b204" width="250" alt="Image"/></td>
    <td><img src="https://github.com/user-attachments/assets/bb9ea671-e1e1-4c6a-b21a-7c779c2aa3af" width="250" alt="Image"/></td>
  </tr>
</table>

---

## ✨ Features

### 🎴 Card Types Supported
- **HC1** - Small Display Card with icon and text
- **HC3** - Big Display Card with image and call-to-action buttons
- **HC5** - Image Card with full-width display
- **HC6** - Small Arrow Card with icon
- **HC9** - Dynamic Width Card with scrollable content

### 🎯 Core Features
- Pull-to-refresh functionality
- Card dismiss - permanently removes card
- Remind later - hides card temporarily until next refresh
- Deep link support via URL launcher
- Dynamic gradient backgrounds
- Formatted text with custom entities
- Error handling with retry mechanism
- Persistent storage using SharedPreferences
- Responsive UI design

---

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── app.dart                          # Main app widget
├── main.dart                         # Entry point
├── config/                           # App configuration
│   ├── constants.dart                # App constants
│   ├── dependency_injection.dart     # DI setup with GetIt
│   └── theme.dart                    # App theme
├── core/                             # Core functionality
│   ├── errors/
│   │   └── exception.dart            # Custom exceptions
│   ├── network/
│   │   └── api_client.dart           # HTTP client
│   ├── services/
│   │   ├── deeplink_service.dart     # URL launcher
│   │   └── storage_service.dart      # SharedPreferences wrapper
│   └── utils/
│       ├── color_utils.dart          # Color parsing utilities
│       ├── gradient_utils.dart       # Gradient builders
│       └── text_style_utils.dart     # Text styling
└── features/
    └── contextual_cards/
        ├── data/                     # Data layer
        │   ├── datasources/
        │   │   └── home_section_remote_datasource.dart
        │   ├── models/               # Data models
        │   └── repositories_impl/
        │       └── home_section_repository_impl.dart
        ├── domain/                   # Domain layer
        │   ├── repositories/
        │   │   └── home_section_repository.dart
        │   └── usecases/
        │       └── home_section_usecase.dart
        └── presentation/             # Presentation layer
            ├── bloc/                 # BLoC state management
            │   ├── home_section_bloc.dart
            │   ├── home_section_event.dart
            │   └── home_section_state.dart
            ├── screens/
            │   └── home_section.dart
            └── widgets/
                ├── cards/            # Individual card types
                ├── common/
                ├── factories/
                │   └── card_factory.dart
                └── contextual_card_list_container.dart  # 🔌 Plug-and-play
```

## 🚀 Setup Guide

### Prerequisites
- Flutter SDK: `>=3.8.1`
- Dart SDK: `>=3.8.1`
- Android Studio / VS Code with Flutter plugins
- Git

### Installation Steps

#### 1. Clone the Repository
```bash
git clone https://github.com/lakshya1goel/famPay-assignment
cd fam_assignment
```

#### 2. Install Dependencies
```bash
flutter pub get
```

#### 3. Create `.env` File
Create a `.env` file in the project root:

```env
BASE_URL=api_base_url
```

#### 4. Verify Setup
```bash
flutter doctor
```

Make sure all checkmarks are green, especially:
- ✓ Flutter
- ✓ Android toolchain (for Android development)
- ✓ Xcode (for iOS development, macOS only)

#### 5. Run the App

**For Android:**
```bash
flutter run
```

**For a specific device:**
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

---

## 🎨 Design Patterns Used

1. **Clean Architecture** - Separation of concerns across data, domain, and presentation layers
2. **Repository Pattern** - Abstract data sources behind repository interfaces
3. **BLoC Pattern** - Predictable state management with events and states
4. **Factory Pattern** - `CardFactory` for creating different card types
5. **Service Locator** - GetIt for dependency injection
6. **Single Responsibility** - Each class has one clear purpose

---

## 🙏 Acknowledgments

- FamPay for the assignment opportunity
- Flutter team for the amazing framework
- Open source community for the packages used
