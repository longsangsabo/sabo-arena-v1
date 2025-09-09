
# Sabo Arena v1 - Billiards Club Management App

A modern Flutter-based billiards club management application with TikTok-style UI and real-time features.

## 🚀 Quick Start

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Application
```bash
export PATH="/tmp/flutter/bin:$PATH"
flutter run -d web-server --web-port=8080
```

### 3. Access App
- **URL**: http://localhost:8080
- **Browser**: Chrome/Edge recommended

## � Features Completed

| Screen | Status | Description |
|--------|---------|-------------|
| 🏠 Home | ✅ Complete | TikTok-style vertical feed |
| 🏛️ Club Profile | ✅ Complete | Club info & member rankings |
| 👤 User Profile | ✅ Complete | Personal stats & tournaments |
| ⚔️ Find Opponent | 🔄 Ready | Player matching (code available) |
| 🏆 Tournament | � TODO | Tournament listings |

## 🔧 Development Commands

```bash
# Hot reload
r

# Hot restart  
R

# Clear console
c

# Quit app
q

# Check errors
flutter analyze
```
## 📁 Project Structure
```
flutter_app/
├── android/            # Android-specific configuration
├── ios/                # iOS-specific configuration
├── lib/
│   ├── core/           # Core utilities and services
│   │   └── utils/      # Utility classes
│   ├── presentation/   # UI screens and widgets
│   │   └── splash_screen/ # Splash screen implementation
│   ├── routes/         # Application routing
│   ├── theme/          # Theme configuration
│   ├── widgets/        # Reusable UI components
│   └── main.dart       # Application entry point
├── assets/             # Static assets (images, fonts, etc.)
├── pubspec.yaml        # Project dependencies and configuration
└── README.md           # Project documentation
```
## 🧩 Adding Routes
To add new routes to the application, update the `lib/routes/app_routes.dart` file:

```dart
import 'package:flutter/material.dart';
import 'package:package_name/presentation/home_screen/home_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    // Add more routes as needed
  }
}
```
## 🎨 Theming

This project includes a comprehensive theming system with both light and dark themes:

```dart
// Access the current theme
ThemeData get theme => ThemeHelper().themeData();

// Use colors
color: theme.colorScheme.primary,
```

## 📱 Responsive Design
The app is built with responsive design using the SizeUtils:

```dart
// Example of responsive sizing
Container(
  width: 50.h,
  height: 20.h,
  child: Text('Responsive Container'),
)
```
## 📦 Deployment
Build the application for production:

```bash
# For Android
flutter build apk --release

# For iOS
flutter build ios --release
```

## 🙏 Acknowledgments
- Built with [Rocket.new](https://rocket.new)
- Powered by [Flutter](https://flutter.dev) & [Dart](https://dart.dev)
- Styled with Material Design

Built with ❤️ on Rocket.new

