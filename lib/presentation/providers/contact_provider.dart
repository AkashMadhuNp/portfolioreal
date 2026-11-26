import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/email_service.dart';
import '../../domain/repositories/message_repository.dart';

class ContactProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _message;

  bool get isLoading => _isLoading;

  /// True after a send that completed; false while idle, loading or failed.
  bool get isSuccess => _isSuccess;

  /// Human-readable result of the last attempt, or null when idle.
  String? get message => _message;

  /// True when the last attempt failed.
  bool get isError => _message != null && !_isSuccess;

  final MessageRepository? messageRepository;

  ContactProvider({this.messageRepository});

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    _isLoading = true;
    _isSuccess = false;
    _message = null;
    notifyListeners();

    try {
      if (messageRepository != null) {
        _message = await messageRepository!.sendMessage(
          name: name,
          email: email,
          message: message,
        );
      } else {
        // 1. Store the message in Firestore. The keys must match
        // firestore.rules (name, email, message, timestamp, recipientEmail),
        // which only allows creates with exactly these required fields.
        await FirebaseFirestore.instance.collection('contact_messages').add({
          'name': name,
          'email': email,
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
          'read': false,
          'recipientEmail': AppConstants.email,
        });

        // 2. Notify by email. The message is already saved, so a failure here
        // is reported as "saved" rather than as an error.
        final emailSent = await EmailService.sendContactEmail(
          senderName: name,
          senderEmail: email,
          message: message,
        );

        _message = emailSent
            ? '✅ Message sent successfully! I\'ll get back to you soon.'
            : '✅ Message saved! Email notification pending. I\'ll respond soon.';
      }
      _isSuccess = true;
    } catch (e) {
      _isSuccess = false;
      _message =
          '❌ Failed to send message. Please try again or email directly to ${AppConstants.email}';
      debugPrint('Error sending message: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessage() {
    _message = null;
    _isSuccess = false;
    notifyListeners();
  }
}
