abstract class MessageRepository {
  Future<String> sendMessage({
    required String name,
    required String email,
    required String message,
  });
}
