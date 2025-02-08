# Task Management App 📋

A simple yet powerful Task Management application built using **Flutter** with **MVVM architecture**. The app features **task management**, **priority setting**, **dark mode**, and **data persistence** with **SQLite** and **Hive**.

## 🚀 Features
- **Task Management**: Add, edit, delete, and view tasks.
- **Priority Setting**: Assign priority (Low, Medium, High) to tasks.
- **Data Persistence**:
    - **SQLite**: Store task details.
    - **Hive**: Store user preferences like theme.
- **State Management**: Riverpod for efficient state management.
- **MVVM Architecture**: Clean separation of concerns.
- **Responsive Design**: Mobile and tablet support.
- **Dark/Light Mode**: Toggle between themes.

## 🛠️ Installation

### Prerequisites
- **Flutter** (>=3.3.0)
- **Dart** (>=3.3.0)

### Steps
1. **Clone the repository**:
    ```bash
    git clone https://github.com/Laxman-sandis/task_management.git
    cd task_management_app
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the project**:
    - For Android:
        ```bash
        flutter run
        ```
    - For iOS:
        ```bash
        flutter run --dart-define=FLUTTER_TARGET=lib/main.dart
        ```

## 💾 Database Setup
- **SQLite**:
    - Automatically creates `tasks.db` in device storage.
    - Uses migrations to add new columns without data loss.
- **Hive**:
    - Stores user preferences in `settings.box`.

## 🗂 Project Structure
```
lib/
│── main.dart
│── app.dart
│
├── core/
│   ├── database/
│   │   └── task_db.dart
│
├── models/
│   ├── task.dart
│   ├── theme_model.dart
│   └── user_preferences.dart
│
├── repository/
│   ├── task_repository.dart
│   └── theme_repository.dart
│
├── resources/
│   └── string_helper.dart
│
├── viewmodels/
│   ├── task_viewmodel.dart
│   └── theme_viewmodel.dart
│
├── views/
│   ├── home_screen.dart
│   └── add_task_screen.dart


```

## 🔧 Development

### Running with Hot Reload
```bash
flutter run
```

### Building for Production
```bash
flutter build apk # For Android
flutter build ios # For iOS
```

## 🧪 Testing
To run unit tests:
```bash
flutter test
```

## 🚦 Troubleshooting
- Ensure **Flutter** and **Dart** are up-to-date:
    ```bash
    flutter upgrade
    ```
- Run **build_runner** if you face Hive issues:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

## 🤝 Contributing
1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`.
3. Make your changes and commit them: `git commit -m 'Add new feature'`.
4. Push to the branch: `git push origin feature-branch`.
5. Submit a pull request.

## 📚 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💬 Feedback
For feedback or inquiries, please reach out to [laxmansandis121@gmail.com].

## 🌟 Acknowledgements
- [Flutter](https://flutter.dev)
- [Riverpod](https://riverpod.dev)
- [SQLite](https://www.sqlite.org)
- [Hive](https://docs.hivedb.dev)

---
**Happy Task Managing!** 🎉

