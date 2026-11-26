/// Form validators for the contact form. Pure Dart so they are unit-testable.
/// Each returns an error message, or null when the value is valid.
class Validators {
  Validators._();

  static const nameMax = 100;
  static const messageMin = 10;
  static const messageMax = 2000;

  // Practical email check: one @, a dotted domain, no spaces. Full RFC 5322
  // validation is deliberately avoided; the server is the real authority.
  static final RegExp _email = RegExp(
    r"^[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?)+$",
  );

  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Please enter your name';
    if (v.length < 2) return 'Your name looks too short';
    if (v.length > nameMax) {
      return 'Please keep your name under $nameMax characters';
    }
    return null;
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Please enter your email';
    if (v.length > 254 || !_email.hasMatch(v)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? message(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Please enter a message';
    if (v.length < messageMin) {
      return 'Please write at least $messageMin characters';
    }
    if (v.length > messageMax) {
      return 'Please keep your message under $messageMax characters';
    }
    return null;
  }
}
