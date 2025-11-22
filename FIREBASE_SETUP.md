# 🔥 Firebase Setup Guide for Contact Form

This guide will help you set up Firebase to receive contact form messages in your portfolio.

## 📋 Prerequisites

- Google Account
- Firebase Project (free tier is sufficient)

---

## 🚀 Step-by-Step Setup

### 1️⃣ Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** or **"Create a project"**
3. Enter project name: `portfolio-contact` (or any name you prefer)
4. Disable Google Analytics (optional for this use case)
5. Click **"Create project"**

---

### 2️⃣ Register Your Web App

1. In your Firebase project dashboard, click the **Web icon** (`</>`)
2. Register app:
   - **App nickname**: `Portfolio Web App`
   - ✅ Check **"Also set up Firebase Hosting"** (optional)
3. Click **"Register app"**

4. **Copy the Firebase configuration** - you'll see something like:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:abcdef123456",
  measurementId: "G-XXXXXXXXXX"
};
```

---

### 3️⃣ Update Your Flutter App

Open `lib/core/services/firebase_service.dart` and replace the placeholder values with your Firebase config:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_API_KEY",              // Replace with your apiKey
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",  // Replace with your authDomain
    projectId: "YOUR_PROJECT_ID",        // Replace with your projectId
    storageBucket: "YOUR_PROJECT_ID.appspot.com",   // Replace with your storageBucket
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",  // Replace with your messagingSenderId
    appId: "YOUR_APP_ID",                // Replace with your appId
    measurementId: "YOUR_MEASUREMENT_ID", // Replace with your measurementId
  ),
);
```

---

### 4️⃣ Set Up Firestore Database

1. In Firebase Console, go to **"Build"** → **"Firestore Database"**
2. Click **"Create database"**
3. Choose **"Start in test mode"** (for development)
   - Location: Choose closest to your users (e.g., `us-central`)
4. Click **"Enable"**

---

### 5️⃣ Configure Firestore Security Rules

Go to **"Firestore Database"** → **"Rules"** tab and update to:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow anyone to write to contact_messages
    match /contact_messages/{messageId} {
      allow create: if request.resource.data.keys().hasAll(['name', 'email', 'message', 'timestamp']);
      allow read, update, delete: if false; // Only you can read via Firebase Console
    }
  }
}
```

Click **"Publish"**

---

### 6️⃣ View Incoming Messages

1. Go to **Firebase Console** → **Firestore Database**
2. You'll see a collection called `contact_messages`
3. Each document will contain:
   ```
   {
     name: "John Doe"
     email: "john@example.com"
     message: "Hi Akash! I'm interested in..."
     timestamp: [server timestamp]
     read: false
     recipientEmail: "002akashakz@gmail.com"
   }
   ```

---

## 📧 Optional: Email Notifications (Advanced)

To automatically send emails when someone contacts you, you need to set up Firebase Cloud Functions:

### Setup Cloud Functions

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. Initialize Functions in your project:
```bash
cd /path/to/your/portfolio
firebase init functions
```

4. Create email function (use Nodemailer or SendGrid)

---

## 🔍 Testing the Contact Form

1. Run your Flutter app:
```bash
flutter run -d chrome
```

2. Navigate to the Contact section
3. Fill out the form with test data
4. Click "Send Message"
5. Check Firebase Console → Firestore Database → `contact_messages` collection
6. You should see your test message!

---

## ✅ Verification Checklist

- [ ] Firebase project created
- [ ] Web app registered in Firebase
- [ ] Firebase config added to `firebase_service.dart`
- [ ] Firestore Database enabled
- [ ] Security rules configured
- [ ] Packages installed (`flutter pub get`)
- [ ] Test message sent successfully
- [ ] Message visible in Firebase Console

---

## 📊 Firestore Data Structure

```
contact_messages (collection)
  └── [auto-generated-id] (document)
      ├── name: string
      ├── email: string
      ├── message: string
      ├── timestamp: timestamp
      ├── read: boolean
      └── recipientEmail: string
```

---

## 🆘 Troubleshooting

### Error: "Firebase not initialized"
- Ensure you've updated `firebase_service.dart` with your actual Firebase config
- Run `flutter pub get` to install packages

### Error: "Permission denied"
- Check Firestore security rules allow `create` operation
- Make sure you're in **test mode** or have proper rules set

### Messages not appearing in Firestore
- Check browser console for errors
- Verify Firebase config is correct
- Ensure Firestore is enabled in Firebase Console

---

## 🎯 Next Steps

Once basic setup is working:

1. **Set up email forwarding** using Firebase Cloud Functions
2. **Add admin dashboard** to view messages in-app
3. **Implement spam protection** using reCAPTCHA
4. **Add analytics** to track form submissions

---

## 📞 Need Help?

- [Firebase Documentation](https://firebase.google.com/docs/web/setup)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Flutter Firebase Setup](https://firebase.flutter.dev/docs/overview)

---

**Your email:** 002akashakz@gmail.com

All messages from the contact form will be stored in your Firebase Firestore database!

