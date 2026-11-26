import 'package:flutter_test/flutter_test.dart';
import 'package:port_folio/core/utils/validators.dart';

void main() {
  group('Validators.name', () {
    test('rejects empty and whitespace-only', () {
      expect(Validators.name(null), isNotNull);
      expect(Validators.name(''), isNotNull);
      expect(Validators.name('   '), isNotNull);
    });

    test('rejects a single character and over-long names', () {
      expect(Validators.name('A'), isNotNull);
      expect(Validators.name('A' * (Validators.nameMax + 1)), isNotNull);
    });

    test('accepts a normal name, ignoring surrounding spaces', () {
      expect(Validators.name('Akash Madhu'), isNull);
      expect(Validators.name('  Li  '), isNull);
    });
  });

  group('Validators.email', () {
    test('accepts common valid addresses', () {
      for (final e in [
        'a@b.co',
        'first.last@example.com',
        'name+tag@sub.domain.org',
        '  spaced@example.com  ',
      ]) {
        expect(Validators.email(e), isNull, reason: e);
      }
    });

    test('rejects malformed addresses', () {
      for (final e in [
        '',
        'plain',
        'no-at.example.com',
        '@example.com',
        'user@',
        'user@example',
        'user@.com',
        'user@@example.com',
        'us er@example.com',
      ]) {
        expect(Validators.email(e), isNotNull, reason: e);
      }
    });
  });

  group('Validators.message', () {
    test('requires a minimum length', () {
      expect(Validators.message(''), isNotNull);
      expect(Validators.message('too short'), isNotNull); // 9 chars
      expect(Validators.message('long enough'), isNull);
    });

    test('rejects messages over the maximum', () {
      expect(Validators.message('x' * Validators.messageMax), isNull);
      expect(Validators.message('x' * (Validators.messageMax + 1)), isNotNull);
    });
  });
}
