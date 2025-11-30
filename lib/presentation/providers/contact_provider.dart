import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/services/email_service.dart';

class ContactProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    try {
      // 1. Store message in Firestore
      await _firestore.collection('contact_messages').add({
        'name': name,
        'senderEmail': email,
        'messageText': message,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'recipientEmail': '002akashakz@gmail.com',
      });

      // 2. Send email via SMTP
      final emailSent = await EmailService.sendContactEmail(
        senderName: name,
        senderEmail: email,
        message: message,
      );

      if (emailSent) {
        _message = '✅ Message sent successfully! I\'ll get back to you soon.';
      } else {
        _message = '✅ Message saved! Email notification pending. I\'ll respond soon.';
      }
    } catch (e) {
      _message = '❌ Failed to send message. Please try again or email directly to 002akashakz@gmail.com';
      debugPrint('Error sending message: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }
}

