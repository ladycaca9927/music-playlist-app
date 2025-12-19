# Music Playlist Application


## Running the Application

This project is a Flutter music playlist application built with Riverpod (hooks_riverpod), GoRouter, and just_audio.

Follow the steps below to run the application locally.

1. Ensure the following are installed on your device:
   - Flutter SDK (version 3.7.0 or later)
   - Dart SDK
   - Android Studio (for Android emulator) or any IDE
   - Xcode 14+ (for IOS simulator)
2. Install dependency
   - flutter pub get
3. IOS Setup (for IOS)
    - cd ios
    - pod install
    - cd ..
4. Run the application
   - Run on the default connected devices
     - flutter run
   - List available devices
     - flutter devices
   - Run on specific device
     - flutter run -d <device_id>
   - Example: 
     - flutter run -d ios
       flutter run -d android
5. If encounter issues
   - flutter clean
     flutter pub get
     flutter run


### Disclaimer

This project uses demo / royalty-free music sources for development and testing only.