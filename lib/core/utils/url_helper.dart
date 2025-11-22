import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch email';
    }
  }

  static Future<void> launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch phone';
    }
  }

  static Future<void> openGitHub(String username) async {
    await launchURL('https://github.com/$username');
  }

  static Future<void> openLinkedIn(String username) async {
    await launchURL('https://linkedin.com/in/$username');
  }

  static Future<void> openTwitter(String username) async {
    await launchURL('https://twitter.com/$username');
  }
}

