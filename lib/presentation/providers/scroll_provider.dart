import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  double _scrollOffset = 0.0;
  String _currentSection = 'home';

  double get scrollOffset => _scrollOffset;
  String get currentSection => _currentSection;

  ScrollProvider() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _scrollOffset = scrollController.offset;
    notifyListeners();
  }

  void setCurrentSection(String section) {
    _currentSection = section;
    notifyListeners();
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

