import 'package:flutter_test/flutter_test.dart';
import 'package:port_folio/domain/repositories/message_repository.dart';
import 'package:port_folio/presentation/providers/contact_provider.dart';

class FakeMessageRepository implements MessageRepository {
  bool shouldFail = false;

  @override
  Future<String> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    if (shouldFail) {
      throw Exception('Fake network error');
    }

    return '✅ Message sent successfully!';
  }
}

void main() {
  group('ContactProvider Tests', () {
    late ContactProvider contactProvider;
    late FakeMessageRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeMessageRepository();
      contactProvider = ContactProvider(messageRepository: fakeRepository);
    });

    test('initial state is correct', () {
      expect(contactProvider.isLoading, isFalse);
      expect(contactProvider.message, isNull);
    });

    test('sendMessage sets loading state properly and succeeds', () async {
      final future = contactProvider.sendMessage(
        name: 'Test Name',
        email: 'test@example.com',
        message: 'Hello World',
      );

      // Right after calling, isLoading should be true
      expect(contactProvider.isLoading, isTrue);

      await future;

      // After completion, isLoading should be false
      expect(contactProvider.isLoading, isFalse);
      expect(contactProvider.message, '✅ Message sent successfully!');
    });

    test('sendMessage handles failure properly', () async {
      fakeRepository.shouldFail = true;

      await contactProvider.sendMessage(
        name: 'Test Name',
        email: 'test@example.com',
        message: 'Hello World',
      );

      expect(contactProvider.isLoading, isFalse);
      expect(
        contactProvider.message,
        '❌ Failed to send message. Please try again or email directly to 002akashakz@gmail.com',
      );
    });

    test('clearMessage resets the message', () async {
      await contactProvider.sendMessage(
        name: 'Test Name',
        email: 'test@example.com',
        message: 'Hello World',
      );

      expect(contactProvider.message, '✅ Message sent successfully!');

      contactProvider.clearMessage();

      expect(contactProvider.message, isNull);
    });
  });
}
