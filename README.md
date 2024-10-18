# Flutter Cinema

## Table of Contents
- [Overview](#overview)
-  [API](#API)
- [firebase](#Firebase)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Folder Structure](#folder-structure)
- [Localization](#localization)
- [Theming](#theming)
- [Contributors](#contributors)
  
## Overview
This is a Flutter-based Cinema application that allows users to browse, search for, and manage their movie-watching tasks. The app integrates a movie database API to provide detailed information about various films, helping users discover and keep track of what they want to watch.  iOS devices.

## API
- **Movie Search**: Retrieve movies based on user queries using a movie database API.
- **Movie Browsing**: Access categories of movies (e.g., popular, top-rated, upcoming) to explore available films.
- **Watchlist Management**: Use an API to manage a personal watchlist, allowing users to add and remove movies.
- **Movie Details**: Fetch detailed information about movies, including title, synopsis, rating, release date, and other relevant data.
-  **Popular Movies**: Access a list of currently popular movies to see what others are watching.
- **Top-Rated Movies**: Fetch a list of the highest-rated movies based on user ratings.
- **Upcoming Movies**: Discover upcoming movie releases to plan future viewings.

## Firebase

To manage the user's watchlist using Firebase, you'll need to set up Firestore to store watchlist data. Here's how to do it:

### 1. Set Up Firebase

- Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
- Add your Flutter app to the project and follow the setup instructions to download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS).

### 2. Add Firebase Dependencies

Add the necessary Firebase dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  firebase_core: ^latest_version
  cloud_firestore: ^latest_version
```
## Screenshots
Include your app screenshots here.

## Getting Started

### Prerequisites
Ensure you have the following installed before running this project:
- Flutter SDK
- Dart SDK
- Android Studio or VS Code

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter_todo_app.git
# Flutter Task Management App

A task management app built with Flutter that supports multiple languages, custom themes, and a structured directory layout for scalability and maintainability.

## Getting Started

To get the project dependencies and run the app on your device or emulator, use the following commands:

```bash
# Fetch project dependencies
flutter pub get

# Run the app
flutter run
```

## Folder Structure

The project follows a structured directory layout to ensure maintainability and scalability:

## Folder Structure
```bash
lib/
  ├── main.dart                # Entry point of the app
  ├── screens/                 # App screens (Home, MovieSearch, MovieDetails, Watchlist, etc.)
  ├── widgets/                 # Custom widgets (MovieItem, WatchlistItem, etc.)
  ├── models/                  # Data models (Movie, Watchlist)
  ├── services/                # API services for movie database integration
  ├── theme/                   # Light and dark theme files
  ├── localization/            # Localization resources for multi-language support
  └── utils/                   # Utility functions (e.g., date formatting, API handling)
```

## Contributors

- **Abdelrahman Wael** - [GitHub Profile](https://github.com/AbdoJoker99)
