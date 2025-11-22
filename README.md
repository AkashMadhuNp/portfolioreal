# 🚀 Professional Flutter Portfolio - Akash Madhu N P

A beautiful, responsive, and animated portfolio website built with Flutter, showcasing professional experience, skills, and projects.

## ✨ Features

### 🎨 Design & UI
- **Responsive Design**: Works seamlessly on mobile, tablet, and desktop
- **Dark/Light Theme**: Toggle between themes with smooth transitions
- **Modern UI**: Clean and professional interface with gradient effects
- **Smooth Animations**: Beautiful entrance and interaction animations
- **Custom Components**: Reusable widgets following Material Design 3

### 🎯 Sections
1. **Hero Section**: Animated introduction with typewriter effect
2. **About**: Personal information with statistics cards
3. **Skills**: Visual representation of technical and soft skills with animated progress bars
4. **Projects**: Showcase of featured projects with hover effects
5. **Experience**: Timeline-based work experience display
6. **Contact**: Functional contact form with social links
7. **Footer**: Social media links and copyright information

### 🔧 Technical Features
- **Clean Architecture**: Organized project structure following clean architecture principles
- **State Management**: Provider for efficient state management
- **Animations**: Multiple animation packages for rich user experience
- **URL Launcher**: Direct links to email, phone, and social media
- **Responsive Utilities**: Custom helper classes for responsive design
- **Custom Theme**: Professional color scheme with gradient support

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart       # App-wide constants
│   │   └── app_strings.dart         # All text strings
│   ├── theme/
│   │   ├── app_colors.dart          # Color definitions
│   │   └── app_theme.dart           # Theme configuration
│   └── utils/
│       ├── responsive_helper.dart   # Responsive utilities
│       └── url_helper.dart          # URL launcher utilities
├── data/
│   └── models/
│       ├── project_model.dart       # Project data
│       ├── skill_model.dart         # Skills data
│       └── experience_model.dart    # Experience data
├── domain/
│   └── entities/
│       ├── project.dart             # Project entity
│       ├── skill.dart               # Skill entity
│       └── experience.dart          # Experience entity
└── presentation/
    ├── providers/
    │   ├── theme_provider.dart      # Theme state management
    │   ├── scroll_provider.dart     # Scroll state management
    │   └── contact_provider.dart    # Contact form state
    ├── widgets/
    │   ├── animated_background.dart # Animated background
    │   ├── custom_app_bar.dart      # Navigation bar
    │   ├── section_title.dart       # Section headers
    │   ├── project_card.dart        # Project display card
    │   ├── skill_card.dart          # Skill display card
    │   ├── experience_card.dart     # Experience display card
    │   └── social_links.dart        # Social media links
    ├── sections/
    │   ├── home_section.dart        # Hero section
    │   ├── about_section.dart       # About section
    │   ├── skills_section.dart      # Skills section
    │   ├── projects_section.dart    # Projects section
    │   ├── experience_section.dart  # Experience section
    │   ├── contact_section.dart     # Contact section
    │   └── footer_section.dart      # Footer section
    └── screens/
        └── portfolio_screen.dart    # Main screen
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd port_folio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Download Poppins Fonts**
   - Visit [Google Fonts - Poppins](https://fonts.google.com/specimen/Poppins)
   - Download the font family
   - Extract and place the following files in `assets/fonts/`:
     - Poppins-Regular.ttf
     - Poppins-Medium.ttf
     - Poppins-SemiBold.ttf
     - Poppins-Bold.ttf

4. **Update Personal Information**
   - Edit `lib/core/constants/app_constants.dart` with your details
   - Update contact information, social links, bio, etc.

5. **Run the app**
   ```bash
   flutter run -d chrome  # For web
   flutter run            # For mobile/desktop
   ```

## 🎨 Customization

### Update Personal Information
Edit `lib/core/constants/app_constants.dart`:
```dart
static const String name = 'Your Name';
static const String role = 'Your Role';
static const String company = 'Your Company';
static const String email = 'your.email@example.com';
// ... etc
```

### Update Projects
Edit `lib/data/models/project_model.dart` to add/modify your projects.

### Update Skills
Edit `lib/data/models/skill_model.dart` to customize your skills.

### Update Experience
Edit `lib/data/models/experience_model.dart` to add your work experience.

### Change Colors
Edit `lib/core/theme/app_colors.dart` to customize the color scheme.

### Add Images
Place your images in:
- `assets/images/` - Profile pictures, project screenshots
- `assets/icons/` - Custom icons
- `assets/animations/` - Lottie animation files

## 📦 Dependencies

### UI & Design
- `google_fonts` - Professional typography
- `flutter_svg` - SVG support
- `font_awesome_flutter` - Icon library

### Animations
- `animate_do` - Pre-built animations
- `animated_text_kit` - Text animations
- `lottie` - Lottie animations support
- `particles_flutter` - Particle effects

### State Management
- `provider` - State management

### Navigation
- `go_router` - Advanced routing

### Utilities
- `url_launcher` - Launch URLs, emails, phone calls
- `responsive_builder` - Responsive design helpers
- `flutter_screenutil` - Screen adaptation
- `smooth_page_indicator` - Page indicators

## 🌐 Deployment

### Web Deployment
```bash
flutter build web --release
```

### Android Deployment
```bash
flutter build apk --release
```

### iOS Deployment
```bash
flutter build ipa --release
```

### Desktop Deployment
```bash
flutter build windows --release  # Windows
flutter build macos --release    # macOS
flutter build linux --release    # Linux
```

## 🎯 Unique Features

1. **Animated Background**: Custom particle-like animated background
2. **Smooth Section Navigation**: Click navigation items to smoothly scroll to sections
3. **Hover Effects**: Interactive hover effects on cards and buttons
4. **Typewriter Effect**: Animated text in hero section
5. **Progress Bar Animations**: Skills display with animated progress bars
6. **Timeline Experience**: Professional timeline display for work experience
7. **Responsive Grid**: Adaptive layouts for all screen sizes
8. **Scroll to Top Button**: Appears when scrolling down
9. **Theme Toggle**: Smooth transition between light and dark themes
10. **Gradient Effects**: Professional gradient colors throughout

## 📱 Responsive Breakpoints

- **Mobile**: < 640px
- **Tablet**: 640px - 1024px
- **Desktop**: > 1024px

## 🤝 Contributing

This is a personal portfolio project. Feel free to fork and customize for your own use!

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

**Akash Madhu N P**
- Flutter Developer at DimensionalLeap
- 1 Year of Experience
- Passionate about creating beautiful mobile experiences

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Google Fonts for typography
- Font Awesome for icons
- Community packages used in this project

---

Made with ❤️ using Flutter
