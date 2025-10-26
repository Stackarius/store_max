# StoreMax

**A smart inventory management app — built for speed, simplicity, and scale.**

StoreMax is a **Flutter-powered inventory & store management app** designed to help small business owners and vendors easily manage their products, track inventory, and streamline operations — all from a clean, modern mobile interface.

It combines **local-first performance** with **Provider-powered state management** and **a smooth, native UI experience**.

---

## Features

### Product Management

- Add, edit, and delete products effortlessly
- Capture or upload product images
- Manage price, stock quantity, and descriptions

### Offline-First Architecture

- Data stored locally using **Sqflite**
- Works fully offline — no internet required
- Automatic data persistence between sessions

### Real-Time UI Updates

- Built with **Provider** for seamless state synchronization
- Changes in product data instantly reflect across the UI

### Sleek Modern UI

- Custom color system with `AppColors.primary`, `AppColors.secondary`, and `AppColors.yellow`
- Responsive layouts
- Animated onboarding powered by `flutter_animate`

### Modular Architecture

- Decoupled and reusable components (`SButton`, `ProductCard`, etc.)
- Scalable structure for easy future integration (like API sync, auth, analytics)

---

## Screens Overview

| Screen                    | Description                                                 |
| ------------------------- | ----------------------------------------------------------- |
| **HomePage**              | Displays all products with Provider-based data updates      |
| **Add/Edit Product Page** | Add new products or edit existing ones with live validation |
| **Product Detail Page**   | View detailed product info, edit or delete directly         |
| **Profile Page**          | Display store owner info, stats, and actions                |
| **Onboarding Page**       | Gradient intro screen with smooth animations                |
| **MainNavigation**        | Centralized bottom navigation (Home + Profile)              |

---

## Tech Stack

| Category             | Stack                                                       |
| -------------------- | ----------------------------------------------------------- |
| **Framework**        | [Flutter 3.x](https://flutter.dev)                          |
| **State Management** | [Provider](https://pub.dev/packages/provider)               |
| **Database**         | [Sqflite](https://pub.dev/packages/sqflite)                 |
| **Fonts**            | [Google Fonts](https://pub.dev/packages/google_fonts)       |
| **Animation**        | [flutter_animate](https://pub.dev/packages/flutter_animate) |
| **Icons & Assets**   | Material Icons, Local Asset Images                          |

---

## Architecture Overview

```
lib/
│
├── contants/                 # App-wide constants like colors
│   └── colors.dart
│
├── models/                   # Data models
│   └── product.dart
│
├── provider/                 # Provider state management
│   └── product_provider.dart
│
├── pages/                    # All UI screens
│   ├── home_page.dart
│   ├── add_edit_product_page.dart
│   ├── product_detail.dart
│   ├── profile_page.dart
│   ├── onboarding_page.dart
│   └── splash_screen.dart
│
├── navigation/               # Main bottom navigation setup
│   └── main_navigation.dart
│
├── utils/                    # Helper functions and initial seeding
│   └── seed_data.dart
│
├── my_widget/                # Reusable widgets
│   └── s_button.dart
│
└── main.dart                 # App entry point
```

---

## Provider Flow

```mermaid
graph TD
A[User Interacts with UI] --> B[Provider Notifies State Change]
B --> C[Database Updates (Sqflite)]
C --> D[Provider Reloads Product List]
D --> E[UI Rebuilds with New Data]
```

---

## Setup Instructions

### 1️ Clone the Repo

```bash
git clone https://github.com/yourusername/storemax.git
cd storemax
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Run the App

```bash
flutter run
```

### 4️⃣ (Optional) Regenerate Splash Screen

If you modify branding assets:

```bash
flutter pub run flutter_native_splash:create
```

---

## Branding

| Asset                 | Path                         | Description              |
| --------------------- | ---------------------------- | ------------------------ |
| App Icon              | `assets/images/store.png`    | App logo                 |
| Splash Background     | `flutter_native_splash.yaml` | Configures native splash |
| Default Product Image | `assets/images/store.png`    | Fallback image           |

---

## Future Roadmap

MVP (Offline Inventory)  
 Sync with Cloud Database (Firebase or Supabase)  
 Integrated Payment Gateway (Paystack SDK)  
 Multi-user Collaboration  
 Advanced Analytics Dashboard  
 AI-Powered Inventory Forecasting

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  sqflite: ^2.3.3
  path_provider: ^2.1.2
  google_fonts: ^6.2.1
  flutter_native_splash: ^2.4.0
  flutter_animate: ^4.5.0
```

---

## 🧑‍💻 Developer

**👨‍💻 Stackr**  
_Aspiring Tech Founder, Flutter Developer, and Web Enthusiast_  
Building **StoreMax**, **PaySplitrr**, and other practical apps for the modern Nigerian market.

- 🐙 [GitHub](www.github.com/Stackarius)

---

## 🏁 License

This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute with attribution.

---

### 💬 Tagline

> _“Because every store deserves a smart system.”_
