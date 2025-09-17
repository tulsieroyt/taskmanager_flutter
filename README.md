<div align="center">
  <h1>Task Manager - Flutter</h1>
  <p>A straightforward and effective task management application built with Flutter to help you organize your workflow and boost your productivity.</p>
  
  <p>
    <a href="https://flutter.dev/">
      <img src="https://img.shields.io/badge/Made%20with-Flutter-02569B.svg" alt="Made with Flutter">
    </a>
    <a href="https://opensource.org/licenses/MIT">
      <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT">
    </a>
  </p>
</div>

## Overview

This project is a fully functional task manager application designed to provide a clean, intuitive, and seamless user experience. It allows users to register, log in, and manage their tasks efficiently, with a focus on core productivity features. The app is built using Flutter, ensuring a native-like performance on both Android and iOS.

## Core Features

*   ✅ **User Authentication:** Secure email/password registration and login.
*   ✅ **Task Creation:** Quickly add new tasks with titles and descriptions.
*   ✅ **Status Management:** Track tasks through different stages (e.g., New, In Progress, Completed, Canceled).
*   ✅ **CRUD Operations:** Full capabilities to Create, Read, Update, and Delete tasks.
*   ✅ **Profile Management:** Users can view and update their profile information.
*   ✅ **Responsive Design:** A clean and modern UI that adapts to various screen sizes.

## Key Technologies & Dependencies

This project leverages a modern tech stack to ensure robustness and scalability.

*   **Framework:** Flutter
*   **Programming Language:** Dart
*   **API Integration:** `http` package for making network requests.
*   **State Management:** GetX
*   **Local Storage:** `shared_preferences` for session management.
*   **UI Components:** `pin_code_fields`, `font_awesome_flutter` for enhanced UI.

## Quick Start Guide

To get a local copy up and running, follow these simple steps.

### Prerequisites

Ensure you have the Flutter SDK installed on your machine. For help, check the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).

### Installation & Execution

1.  **Clone the Repository**
    ```sh
    git clone https://github.com/tulsieroyt/taskmanager_flutter.git
    ```
2.  **Navigate to the Project Directory**
    ```sh
    cd taskmanager_flutter
    ```
3.  **Install Required Packages**
    ```sh
    flutter pub get
    ```
4.  **Run the App**
    ```sh
    flutter run
    ```
    The app should now be running on your connected device or emulator.

## Codebase Structure

The project's source code is organized into a clean and maintainable structure:

```
lib/
├── api/
│   └── api_client.dart       # Handles network requests
├── app.dart                  # Main application widget
├── main.dart                 # Application entry point
├── screens/                  # All UI screens (login, signup, tasks, etc.)
├── style/
│   └── style.dart            # Centralized styling and themes
├── utility/
│   └── utility.dart          # Helper functions and utilities
└── widgets/
    └── ...                   # Reusable UI components
```

## How to Contribute

Contributions are welcome and appreciated! Whether it's fixing a bug, proposing a new feature, or improving documentation, your help is valued.

1.  Fork the repository.
2.  Create a new branch (`git checkout -b feature/YourFeatureName`).
3.  Make your changes and commit them (`git commit -m 'feat: Add some feature'`).
4.  Push to your branch (`git push origin feature/YourFeatureName`).
5.  Open a Pull Request.

## License

This project is licensed under the MIT License. See the [`LICENSE`](https://github.com/tulsieroyt/taskmanager_flutter/blob/master/LICENSE) file for more details.

---

<div align="center">
  <p>Made with ❤️ by Tulsie Chandra Barman</p>
</div>
