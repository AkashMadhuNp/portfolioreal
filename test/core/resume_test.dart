import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:port_folio/core/constants/app_constants.dart';

void main() {
  group('Résumé download', () {
    final file = File(AppConstants.resumeAsset);

    test('the configured file exists and is a real PDF', () {
      expect(file.existsSync(), isTrue, reason: AppConstants.resumeAsset);
      final bytes = file.readAsBytesSync();
      expect(bytes.length, greaterThan(10 * 1024));
      // Every PDF starts with the "%PDF-" signature.
      expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    });

    test('it is the only PDF shipped in assets/files', () {
      final pdfs = Directory('assets/files')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.toLowerCase().endsWith('.pdf'))
          .map((f) => f.uri.pathSegments.last)
          .toList();
      expect(pdfs, [AppConstants.resumeFileName]);
    });

    test('the download name matches the file name', () {
      expect(
        AppConstants.resumeAsset.split('/').last,
        AppConstants.resumeFileName,
      );
    });

    test('the web URL carries the extra "assets/" prefix Flutter web adds', () {
      expect(
        AppConstants.resumeWebUrl,
        'assets/assets/files/Akash_Madhu_Resume.pdf',
      );
    });

    test('no source file still references an old résumé filename', () {
      const stale = ['Akash_Madhu_2026', 'Akash_Madhu_Flutter_Resume'];
      final offenders = <String>[];
      for (final dir in ['lib', 'tool', 'web']) {
        for (final entity in Directory(dir).listSync(recursive: true)) {
          if (entity is! File) continue;
          final path = entity.path;
          if (!(path.endsWith('.dart') ||
              path.endsWith('.html') ||
              path.endsWith('.json') ||
              path.endsWith('.xml'))) {
            continue;
          }
          final text = entity.readAsStringSync();
          for (final s in stale) {
            if (text.contains(s)) offenders.add('$path -> $s');
          }
        }
      }
      expect(offenders, isEmpty);
    });
  });
}
