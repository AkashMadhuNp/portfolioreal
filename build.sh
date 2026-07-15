#!/bin/bash
echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
echo "Enabling Web..."
flutter config --enable-web
echo "Installing Dependencies..."
flutter pub get
echo "Building Web..."
flutter build web --release