# 📂 Complete Folder Structure

```
port_folio/
│
├── 📄 README.md                          # Main documentation
├── 📄 SETUP_INSTRUCTIONS.md             # Detailed setup guide
├── 📄 QUICK_START.md                    # 5-minute quick start
├── 📄 PROJECT_SUMMARY.md                # Project overview
├── 📄 FOLDER_STRUCTURE.md               # This file
├── 📄 pubspec.yaml                       # Dependencies
├── 📄 analysis_options.yaml              # Linter rules
├── 📄 .gitignore                         # Git ignore rules
│
├── 📁 assets/                            # Asset files
│   ├── 📁 images/                        # Images (profile, projects)
│   │   └── .gitkeep
│   ├── 📁 icons/                         # Custom icons
│   │   └── .gitkeep
│   ├── 📁 animations/                    # Lottie animations
│   │   └── .gitkeep
│   └── 📁 fonts/                         # Local fonts (optional)
│       └── Poppins-Regular.ttf
│
├── 📁 lib/                               # Main source code
│   ├── 📄 main.dart                      # App entry point
│   │
│   ├── 📁 core/                          # Core utilities
│   │   ├── 📁 constants/
│   │   │   ├── app_constants.dart        # App constants (name, email, etc.)
│   │   │   └── app_strings.dart          # All UI strings
│   │   ├── 📁 theme/
│   │   │   ├── app_colors.dart           # Color definitions
│   │   │   └── app_theme.dart            # Theme configuration
│   │   └── 📁 utils/
│   │       ├── responsive_helper.dart    # Responsive utilities
│   │       └── url_helper.dart           # URL launcher helper
│   │
│   ├── 📁 domain/                        # Domain layer (Business logic)
│   │   └── 📁 entities/
│   │       ├── project.dart              # Project entity
│   │       ├── skill.dart                # Skill entity
│   │       └── experience.dart           # Experience entity
│   │
│   ├── 📁 data/                          # Data layer
│   │   └── 📁 models/
│   │       ├── project_model.dart        # Project data
│   │       ├── skill_model.dart          # Skills data
│   │       └── experience_model.dart     # Experience data
│   │
│   └── 📁 presentation/                  # Presentation layer (UI)
│       ├── 📁 providers/                 # State management
│       │   ├── theme_provider.dart       # Theme state
│       │   ├── scroll_provider.dart      # Scroll state
│       │   └── contact_provider.dart     # Contact form state
│       │
│       ├── 📁 widgets/                   # Reusable widgets
│       │   ├── animated_background.dart  # Animated background
│       │   ├── custom_app_bar.dart       # Navigation bar
│       │   ├── section_title.dart        # Section headers
│       │   ├── project_card.dart         # Project card widget
│       │   ├── skill_card.dart           # Skill card widget
│       │   ├── experience_card.dart      # Experience card widget
│       │   └── social_links.dart         # Social media links
│       │
│       ├── 📁 sections/                  # Page sections
│       │   ├── home_section.dart         # Hero/Home section
│       │   ├── about_section.dart        # About section
│       │   ├── skills_section.dart       # Skills section
│       │   ├── projects_section.dart     # Projects section
│       │   ├── experience_section.dart   # Experience section
│       │   ├── contact_section.dart      # Contact section
│       │   └── footer_section.dart       # Footer section
│       │
│       └── 📁 screens/
│           └── portfolio_screen.dart     # Main portfolio screen
│
├── 📁 android/                           # Android platform files
├── 📁 ios/                               # iOS platform files
├── 📁 web/                               # Web platform files
├── 📁 windows/                           # Windows platform files
├── 📁 macos/                             # macOS platform files
├── 📁 linux/                             # Linux platform files
└── 📁 test/                              # Test files
    └── widget_test.dart
```

## 🎯 Key Files to Customize

### Must Edit:
1. **`lib/core/constants/app_constants.dart`** - Your personal info
2. **`lib/data/models/project_model.dart`** - Your projects
3. **`lib/data/models/skill_model.dart`** - Your skills
4. **`lib/data/models/experience_model.dart`** - Your work experience

### Optional:
5. **`lib/core/theme/app_colors.dart`** - Change colors
6. **`assets/images/`** - Add your images
7. **`lib/core/constants/app_strings.dart`** - Change UI text

## 📊 File Count by Category

### Source Code (Dart files): 28 files
- Core: 5 files
- Domain: 3 files
- Data: 3 files
- Presentation: 16 files
- Main: 1 file

### Documentation: 5 files
- README.md
- SETUP_INSTRUCTIONS.md
- QUICK_START.md
- PROJECT_SUMMARY.md
- FOLDER_STRUCTURE.md

### Configuration: 3 files
- pubspec.yaml
- analysis_options.yaml
- .gitignore

### Assets: 4 folders
- images/
- icons/
- animations/
- fonts/

**Total Dart Lines of Code: ~2,500+ lines**

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────┐
│           Presentation Layer                │
│  (UI, Widgets, Screens, State Management)   │
└─────────────────┬───────────────────────────┘
                  │
                  ↓
┌─────────────────────────────────────────────┐
│             Domain Layer                     │
│     (Business Logic, Entities)               │
└─────────────────┬───────────────────────────┘
                  │
                  ↓
┌─────────────────────────────────────────────┐
│              Data Layer                      │
│        (Models, Data Sources)                │
└─────────────────────────────────────────────┘
                  │
                  ↓
        ┌─────────────────┐
        │   Core Layer     │
        │ (Utilities, etc) │
        └─────────────────┘
```

## 🎨 Widget Tree

```
MaterialApp
  └── MultiProvider
      └── PortfolioScreen
          └── AnimatedBackground
              ├── CustomAppBar
              └── SingleChildScrollView
                  ├── HomeSection
                  ├── AboutSection
                  ├── SkillsSection
                  ├── ProjectsSection
                  ├── ExperienceSection
                  ├── ContactSection
                  └── FooterSection
```

## 📦 Dependencies Flow

```
main.dart
  ↓
Providers (Theme, Scroll, Contact)
  ↓
PortfolioScreen
  ↓
Sections (Home, About, Skills, etc.)
  ↓
Widgets (Cards, Buttons, etc.)
  ↓
Core (Theme, Utils, Constants)
  ↓
Models (Data)
  ↓
Entities (Domain)
```

---

**Navigation Guide:**
- Start with `main.dart` to understand app initialization
- Check `app_constants.dart` for personal info
- Browse `sections/` folder for each page section
- Look at `widgets/` for reusable components
- Modify `models/` to change your data

Happy coding! 🚀

