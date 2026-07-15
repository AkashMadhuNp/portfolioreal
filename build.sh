#!/bin/bash
set -e

echo "Installing Flutter..."

git clone https://github.com/flutter/flutter.git --depth 1 -b stable

export PATH="$PWD/flutter/bin:$PATH"

flutter doctor

flutter pub get

flutter build web --release