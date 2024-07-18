# Rebake Flutter App

Welcome to Tezda, a Flutter application. This README will guide you through setting up the development environment.

## Prerequisites

- Flutter SDK
- Dart SDK
- FVM (Flutter Version Manager)
- VS Code or Android Studio

## Setting Up FVM

FVM helps you manage Flutter versions and ensures consistency across different environments. The project contains a `.fvm/fvm_config.json` file specifying the required Flutter version. You only need to have FVM installed.

## Key Implementation Details

Local Storage:

Used shared_preferences for storing credentials and favorites locally for quick prototyping.
Implemented cached authentication and cached favorites to enhance performance and offline availability.
State Management:

Used the provider package for managing authentication state.
Form Validation:

Utilized Form and TextFormField for user input validation.
Navigation:

Employed named routes for clean navigation.
Fetching Data:

Integrated (https://fakestoreapi.com/products/) for real product data.
