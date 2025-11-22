import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import 'toast_helper.dart';

class DownloadHelper {
  /// Download CV for web platform
  static Future<void> downloadCV(BuildContext context) async {
    if (kIsWeb) {
      // For web: Direct download using anchor element
      const url = 'assets/files/AkashMadhu-RESUME_FLUTTER .pdf';
      
      // Create a temporary anchor element and trigger download
      html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'Akash_Madhu_Flutter_Resume.pdf'
        ..click();
      
      // Show success toast
      ToastHelper.showSuccessToast(
        context,
        '📄 CV downloaded successfully!',
      );
    } else {
      // For mobile/desktop: Use url_launcher
      const url = 'assets/files/AkashMadhu-RESUME_FLUTTER .pdf';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        ToastHelper.showSuccessToast(
          context,
          '📄 Opening CV...',
        );
      } else {
        ToastHelper.showErrorToast(
          context,
          '❌ Unable to open CV',
        );
      }
    }
  }

  /// Open CV in new tab (alternative method)
  static void openCVInNewTab() {
    if (kIsWeb) {
      html.window.open(
        'assets/files/AkashMadhu-RESUME_FLUTTER .pdf',
        '_blank',
      );
    }
  }
}

