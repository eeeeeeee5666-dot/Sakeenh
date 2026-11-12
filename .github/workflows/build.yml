name: Build APK

on:
  push:
    branches: [ "main", "master" ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'

      - name: Create Project Skeleton
        run: |
          mkdir temp_lib
          cp lib/main.dart temp_lib/main.dart
          flutter create --org com.sakeenah.app app
          cp temp_lib/main.dart app/lib/main.dart
          cd app
          flutter build apk --release

      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: Sakeenah-Release-APK
          path: app/build/app/outputs/flutter-apk/app-release.apk
