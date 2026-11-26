/// A concrete engineering capability, backed by work described in the
/// experience and project content. [context] names where it was done so each
/// claim can be traced.
class EngineeringHighlight {
  final String id;
  final String title;
  final String description;
  final String context;
  final String iconKey;
  final List<String> tags;

  const EngineeringHighlight({
    required this.id,
    required this.title,
    required this.description,
    required this.context,
    required this.iconKey,
    this.tags = const [],
  });
}
