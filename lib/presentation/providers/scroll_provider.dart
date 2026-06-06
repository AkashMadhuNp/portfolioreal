import 'dart:async';
import 'package:flutter/material.dart';

enum ScrollDirectionState {
  idle,
  scrollingUp,
  scrollingDown,
}

class ScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  double _scrollOffset = 0.0;
  String _currentSection = 'home';
  ScrollDirectionState _scrollState = ScrollDirectionState.idle;
  Timer? _stopScrollTimer;

  double get scrollOffset => _scrollOffset;
  String get currentSection => _currentSection;
  ScrollDirectionState get scrollState => _scrollState;

  ScrollProvider() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    
    final currentOffset = scrollController.offset;
    final delta = currentOffset - _scrollOffset;
    
    ScrollDirectionState newDirection = _scrollState;
    if (delta > 0.5) {
      newDirection = ScrollDirectionState.scrollingDown;
    } else if (delta < -0.5) {
      newDirection = ScrollDirectionState.scrollingUp;
    }
    
    _scrollOffset = currentOffset;
    
    if (newDirection != _scrollState) {
      _scrollState = newDirection;
      notifyListeners();
    }
    
    _stopScrollTimer?.cancel();
    _stopScrollTimer = Timer(const Duration(milliseconds: 200), () {
      if (_scrollState != ScrollDirectionState.idle) {
        _scrollState = ScrollDirectionState.idle;
        notifyListeners();
      }
    });
    
    // Always notify offset changes to update thumb position
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
    _stopScrollTimer?.cancel();
    scrollController.dispose();
    super.dispose();
  }
}

