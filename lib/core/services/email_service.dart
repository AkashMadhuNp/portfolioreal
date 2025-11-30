import 'dart:convert';
import 'package:http/http.dart' as http;

/// Email service using EmailJS (works on Flutter Web)
/// 
/// Setup:
/// 1. Sign up at https://www.emailjs.com/
/// 2. Add an email service (Gmail)
/// 3. Create an email template
/// 4. Get your Public Key, Service ID, and Template ID
/// 5. Update the constants below
class EmailService {
  // EmailJS Configuration
  // Get these from: https://dashboard.emailjs.com/
  static const String _publicKey = 'SIJdlpP1x3Dvr1vcC';
  static const String _serviceId = 'service_7z679kb';
  static const String _templateId = 'template_7vjgxv7';
  
  static const String _emailJsUrl = 'https://api.emailjs.com/api/v1.0/email/send';
  
  /// Send contact form email via EmailJS
  static Future<bool> sendContactEmail({
    required String senderName,
    required String senderEmail,
    required String message,
  }) async {
    try {
      // Prepare email parameters
      final Map<String, dynamic> emailParams = {
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _publicKey,
        'template_params': {
          'from_name': senderName,
          'from_email': senderEmail,
          'message': message,
          'to_email': '002akashakz@gmail.com',
          'reply_to': senderEmail,
          'timestamp': DateTime.now().toString(),
        },
      };
      
      // Send email via EmailJS API
      final response = await http.post(
        Uri.parse(_emailJsUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(emailParams),
      );
      
      if (response.statusCode == 200) {
        print('✅ Email sent successfully via EmailJS');
        return true;
      } else {
        print('❌ EmailJS error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('❌ Error sending email: $e');
      return false;
    }
  }
}
