# ⚡ Quick Start Guide

Get your portfolio running in 5 minutes!

## 1️⃣ Install Dependencies (30 seconds)

```bash
flutter pub get
```

## 2️⃣ Update Your Info (2 minutes)

Open `lib/core/constants/app_constants.dart` and update:

```dart
// Change these to your details:
static const String name = 'Akash Madhu N P';           // ← Your name
static const String email = 'akashmadhu@example.com';  // ← Your email
static const String github = 'https://github.com/...'; // ← Your GitHub
static const String linkedin = 'https://linkedin...';  // ← Your LinkedIn
```

## 3️⃣ Run the App (30 seconds)

```bash
flutter run -d chrome
```

That's it! Your portfolio is now running! 🎉

---

## 📝 Next Steps (Optional)

### Add Your Projects
Edit `lib/data/models/project_model.dart`

### Update Skills
Edit `lib/data/models/skill_model.dart`

### Add Experience
Edit `lib/data/models/experience_model.dart`

### Change Colors
Edit `lib/core/theme/app_colors.dart`

---

## 🚀 Deploy to Web

```bash
flutter build web --release
```

Then upload the `build/web/` folder to:
- Firebase Hosting
- Netlify
- GitHub Pages
- Vercel

---

## 💡 Tips

- The app works on mobile, tablet, and desktop automatically
- Toggle dark/light theme with the button in the top right
- Click navigation items to jump to sections
- All animations work automatically
- No backend needed - everything is client-side

---

## ❓ Need Help?

Check the full documentation in `README.md` and `SETUP_INSTRUCTIONS.md`

Happy coding! 🚀

