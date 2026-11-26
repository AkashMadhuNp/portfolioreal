import 'package:flutter/material.dart';
import '../../../core/utils/toast_helper.dart';
import '../../../core/utils/url_helper.dart';

/// Opens [url] and shows an error toast if it cannot be launched, so a broken
/// link never fails silently or throws into the console.
Future<void> openLink(BuildContext context, String url) async {
  try {
    await UrlHelper.launchURL(url);
  } catch (_) {
    if (context.mounted) {
      ToastHelper.showErrorToast(context, 'Could not open this link.');
    }
  }
}
