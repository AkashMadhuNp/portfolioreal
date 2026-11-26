import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../constants/app_constants.dart';
import 'toast_helper.dart';

class DownloadHelper {
  /// Downloads the résumé ([AppConstants.resumeAsset]).
  static Future<void> downloadCV(BuildContext context) async {
    if (kIsWeb) {
      // Same-origin anchor with the `download` attribute: the browser saves the
      // file under [AppConstants.resumeFileName] instead of navigating to it.
      html.AnchorElement(href: AppConstants.resumeWebUrl)
        ..download = AppConstants.resumeFileName
        ..click();

      ToastHelper.showSuccessToast(context, '📄 CV downloaded successfully!');
    } else {
      // Off-web fallback: hand the asset path to the platform.
      final uri = Uri.parse(AppConstants.resumeAsset);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (context.mounted) {
          ToastHelper.showSuccessToast(context, '📄 Opening CV...');
        }
      } else if (context.mounted) {
        ToastHelper.showErrorToast(context, '❌ Unable to open CV');
      }
    }
  }

  /// Opens the résumé in a new tab instead of downloading it.
  static void openCVInNewTab() {
    if (kIsWeb) {
      html.window.open(AppConstants.resumeWebUrl, '_blank');
    }
  }
}
