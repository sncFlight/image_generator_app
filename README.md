# AI Image Generator

Flutter application demonstrating AI image generation with BLoC state management.

## Features

- **Prompt Input Screen**: Enter text description with validation
- **Result Screen**: Shows loading state, generated image, or error handling
- **Try Another**: Regenerate with same prompt
- **New Prompt**: Return to input screen with saved text
- **Error Handling**: ~50% generation failure simulation with retry option

## Tech Stack

- Flutter 3+
- **flutter_bloc** for state management
- go_router for navigation
- null-safety enabled
- Clean architecture with separation of concerns

## Setup and Run

### Prerequisites

- Flutter SDK 3.0+
- Xcode (for iOS)
- Android Studio (for Android)

### Installation

1. Clone the repository:

git clone https://github.com/sncFlight/image_generator_app
cd image_generator_app

2. Install dependencies:

flutter pub get

3. Run the app:

For iOS

flutter run -d "Your ios device name"
For Android

flutter run -d "Your android device name"

### iOS Signing Setup

Before running on iOS:

1. Open project in Xcode:

open ios/Runner.xcworkspace

2. In Xcode:
   - Select **Runner** target
   - Go to **Signing & Capabilities**
   - Select your **Team**