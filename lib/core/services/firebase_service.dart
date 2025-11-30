import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../../firebase_options.dart';

class FirebaseService {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint('✅ Firebase initialized successfully');
      debugPrint('📊 Project: portfolio-6e957');
    } catch (e) {
      debugPrint('❌ Firebase initialization error: $e');
      rethrow;
    }
  }
}

