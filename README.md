# Student Information Form

A simple Flutter app that collects a student's email address, phone number, and password through a validated form.

## Features

- **Email validation**: required, and must be a valid email format.
- **Phone validation**: required, digits only, exactly 11 digits.
- **Password validation**: at least 8 characters, with an uppercase letter, a lowercase letter, a number, and a symbol.
- **Show/hide password** toggle.
- **Success dialog** shown after a valid submission.

## Getting Started

```bash
flutter pub get
flutter run
```

## Running Tests

```bash
flutter test
```

## Project Structure

- `lib/main.dart` – app entry point and form screen
- `test/widget_test.dart` – widget tests for validation, submission, and password toggle
