
---

# Todo List App

A Flutter application for managing tasks with full CRUD functionality connected to a REST API.

---

## Overview

This app allows users to:

* View a list of tasks
* Add new tasks
* Edit existing tasks
* Delete tasks

All task data is fetched and stored via a REST API, with state management implemented using the Bloc pattern for clear separation of concerns and maintainability.

---

## Features

* Display tasks with their completion status
* Add, update, and delete tasks
* Error handling and user feedback (e.g., no internet connection)
* State management using `flutter_bloc` package
* Clean and modular architecture for easy scalability
* minimalism, responsive & easy to use

---

## Getting Started

### Prerequisites

* Flutter SDK installed ([install guide](https://docs.flutter.dev/get-started/install))
* A device or emulator to run the app

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/AhmadShodikinn/todo_app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd todo_list_app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

---

## Architecture and State Management

* Uses **Bloc pattern** (`flutter_bloc`) to manage state and separate UI from business logic.
* Events trigger async operations (like API calls), and states update UI accordingly.
* Handles loading, success, failure, and error states gracefully.

---

## REST API

* The app connects to a REST API for data operations (GET, POST, PUT, DELETE).
* Base URL and endpoints are configured inside the data layer (refer to the code for details).
* Includes error handling for cases like network failure or server errors.

---

## Additional Notes

* The app provides user feedback via snackbars on task operations success or failure.
* Pull-to-refresh or retry mechanisms are included to handle connectivity issues.
* UI is designed to be clean and user-friendly.

---

## Screenshots (optional)

![WhatsApp Image 2025-09-27 at 07 48 05_64538d75](https://github.com/user-attachments/assets/cce98e29-b107-4709-b084-ad999b08c8b4)
![WhatsApp Image 2025-09-27 at 07 48 05_05b6fbb8](https://github.com/user-attachments/assets/39af9f7c-6ba2-498c-a13a-5000eace93df)
![WhatsApp Image 2025-09-27 at 07 48 06_106c4c38](https://github.com/user-attachments/assets/464a2d0d-faf0-4996-a488-a5dccd03418e)
![WhatsApp Image 2025-09-27 at 07 48 06_3363b118](https://github.com/user-attachments/assets/941e4953-fa02-4051-a657-96d63a8b507c)
![WhatsApp Image 2025-09-27 at 07 48 07_be8ab46d](https://github.com/user-attachments/assets/613e4cce-dbc2-4ac7-800c-c29aa7a83404)
![WhatsApp Image 2025-09-27 at 07 48 07_d8ee8013](https://github.com/user-attachments/assets/61828f81-a748-494f-84fe-f6e61c481dc7)
![WhatsApp Image 2025-09-27 at 07 48 07_ac41561e](https://github.com/user-attachments/assets/f2125de8-735c-4d69-9c2b-2b78ae76670c)
![WhatsApp Image 2025-09-27 at 07 48 05_fed64eac](https://github.com/user-attachments/assets/bd60ccd8-7950-493c-9dbc-bd4bf22d0461)
![WhatsApp Image 2025-09-27 at 07 48 08_2d19729d](https://github.com/user-attachments/assets/807c5da1-0bec-45cc-aafc-b3e777d01fac)


---
