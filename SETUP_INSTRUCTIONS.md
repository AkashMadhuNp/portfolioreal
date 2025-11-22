# 📋 Setup Instructions

Follow these steps to get your portfolio up and running:

## Step 1: Install Dependencies

Run the following command in the project root:

```bash
flutter pub get
```

## Step 2: Setup Fonts

The project uses Poppins font. You have two options:

### Option A: Use Google Fonts Online (Recommended)
The project is already configured to use `google_fonts` package which will automatically download and cache the fonts. No additional setup needed!

### Option B: Use Local Fonts
1. Download Poppins from [Google Fonts](https://fonts.google.com/specimen/Poppins)
2. Extract and place these files in `assets/fonts/`:
   - Poppins-Regular.ttf
   - Poppins-Medium.ttf
   - Poppins-SemiBold.ttf
   - Poppins-Bold.ttf

## Step 3: Update Personal Information

### 3.1 Basic Information
Edit `lib/core/constants/app_constants.dart`:

```dart
// Personal Information
static const String name = 'YOUR NAME';
static const String role = 'YOUR ROLE';
static const String company = 'YOUR COMPANY';
static const String experience = 'YOUR EXPERIENCE';
static const String bio = 'YOUR BIO';

// Contact Information
static const String email = 'your.email@example.com';
static const String phone = '+XX XXXXX XXXXX';
static const String location = 'YOUR LOCATION';
static const String github = 'https://github.com/yourusername';
static const String linkedin = 'https://linkedin.com/in/yourusername';
static const String twitter = 'https://twitter.com/yourusername';
```

### 3.2 Update Projects
Edit `lib/data/models/project_model.dart` to add your projects:

```dart
const Project(
  id: 'unique-id',
  title: 'Your Project Title',
  description: 'Project description...',
  technologies: ['Flutter', 'Firebase', 'etc.'],
  category: 'Mobile App',
  isFeatured: true,
  liveUrl: 'https://yourproject.com',
  githubUrl: 'https://github.com/yourusername/project',
),
```

### 3.3 Update Skills
Edit `lib/data/models/skill_model.dart` to customize skills:

```dart
Skill(
  name: 'Skill Name',
  proficiency: 0.9, // 0.0 to 1.0
  category: 'Category',
),
```

### 3.4 Update Experience
Edit `lib/data/models/experience_model.dart`:

```dart
Experience(
  id: 'unique-id',
  company: 'Company Name',
  position: 'Your Position',
  duration: 'Start Date - End Date',
  location: 'Location',
  isCurrent: true,
  responsibilities: [
    'Responsibility 1',
    'Responsibility 2',
  ],
),
```

## Step 4: Add Your Images (Optional)

Replace the placeholder avatar in `HomeSection` with your image:

1. Add your image to `assets/images/profile.png`
2. Update `lib/presentation/sections/home_section.dart`:

```dart
// Replace the Icon widget with:
ClipOval(
  child: Image.asset(
    'assets/images/profile.png',
    width: size,
    height: size,
    fit: BoxFit.cover,
  ),
),
```

## Step 5: Test the App

### For Web:
```bash
flutter run -d chrome
```

### For Mobile:
```bash
# Android
flutter run

# iOS (Mac only)
flutter run -d ios
```

### For Desktop:
```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## Step 6: Build for Production

### Web:
```bash
flutter build web --release
```
Output will be in `build/web/`

### Android:
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS (Mac only):
```bash
flutter build ipa --release
```

### Desktop:
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## Troubleshooting

### Issue: Font not loading
**Solution**: The app uses `google_fonts` package which requires internet on first run. After that, fonts are cached. Alternatively, download and use local fonts (see Step 2, Option B).

### Issue: Pubspec errors
**Solution**: Make sure you're using Flutter SDK 3.9.2 or higher:
```bash
flutter --version
flutter upgrade
```

### Issue: Web build not working
**Solution**: Enable web support:
```bash
flutter config --enable-web
flutter create .
```

### Issue: Assets not found
**Solution**: Run:
```bash
flutter clean
flutter pub get
```

## Deployment

### Deploy to Firebase Hosting:
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase
firebase init hosting

# Build and deploy
flutter build web --release
firebase deploy
```

### Deploy to GitHub Pages:
1. Build web version: `flutter build web --release`
2. Push `build/web/` contents to `gh-pages` branch
3. Enable GitHub Pages in repository settings

### Deploy to Netlify:
1. Build: `flutter build web --release`
2. Drag and drop `build/web/` folder to Netlify
3. Or connect GitHub repository for auto-deploy

## Customization Tips

1. **Change Theme Colors**: Edit `lib/core/theme/app_colors.dart`
2. **Modify Animations**: Adjust durations in individual sections
3. **Add/Remove Sections**: Edit `lib/presentation/screens/portfolio_screen.dart`
4. **Change Layout**: Modify responsive breakpoints in `lib/core/utils/responsive_helper.dart`

## Need Help?

If you encounter any issues:
1. Check Flutter version: `flutter doctor`
2. Clean and rebuild: `flutter clean && flutter pub get`
3. Check the Flutter documentation: https://flutter.dev/docs
4. Review the code comments for guidance

---

Good luck with your portfolio! 🚀

