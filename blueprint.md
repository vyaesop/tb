# Project Blueprint: Flutter Telebirr Clone with SQLite

## Overview

This document outlines the plan for developing a Flutter application that mimics the core functionality of a mobile money service like Telebirr. The application will use SQLite for local data storage, making it a completely offline-first application.

## Core Features

*   **Dashboard:** A home screen that displays the current balance and provides access to major actions.
*   **Transaction History:** A screen that lists all past transactions.
*   **Send Money:** A feature to simulate sending money, which will create a new transaction and update the balance.
*   **Receive Money:** A feature to simulate receiving money.
*   **Local Data Persistence:** All data will be stored locally on the device using an SQLite database.

## Design and Theming

*   **Theme:** A modern, clean theme using Material Design 3.
*   **Color Scheme:** A color scheme generated from a seed color to ensure consistency.
*   **Typography:** Custom fonts using the `google_fonts` package for a polished look.
*   **Iconography:** Use of Material icons to enhance user understanding.

## Technical Plan

### 1. Project Setup & Dependencies

*   Add the following packages to `pubspec.yaml`:
    *   `sqflite`: To interact with the SQLite database.
    *   `path`: To find the correct path for storing the database file.
    *   `provider`: For simple state management to share data across the UI.
    *   `google_fonts`: For custom typography.
    *   `intl`: For date formatting.

### 2. Database Schema

*   A single table named `transactions` will be created with the following columns:
    *   `id`: INTEGER PRIMARY KEY AUTOINCREMENT
    *   `description`: TEXT NOT NULL
    *   `amount`: REAL NOT NULL
    *   `type`: TEXT NOT NULL ('send' or 'receive')
    *   `date`: TEXT NOT NULL

### 3. Application Architecture

*   **Model:** A `Transaction` model class to represent the data from the `transactions` table.
*   **Database Helper:** A singleton class (`DatabaseHelper`) to manage all database operations (CRUD).
*   **State Management:** A `ThemeProvider` to manage the app's theme and a `TransactionProvider` to manage the transaction state.
*   **UI (View):** A set of screens and widgets to display the UI.

### 4. Implementation Steps

1.  **Update `pubspec.yaml`** with the necessary dependencies.
2.  **Create the `DatabaseHelper`** class to handle database initialization and CRUD operations.
3.  **Create the `Transaction` model**.
4.  **Set up the main application structure** in `lib/main.dart`, including the theme and providers.
5.  **Build the `HomeScreen`** to display the balance, a summary of recent transactions, and action buttons.
6.  **Build the `SendMoneyScreen`** and `ReceiveMoneyScreen` with simple forms.
7.  **Build the `TransactionHistoryScreen`** to display all transactions.
8.  **Connect the UI to the database** through the providers to make the app functional.
9.  **Refine the UI/UX** with animations and polished design elements.
