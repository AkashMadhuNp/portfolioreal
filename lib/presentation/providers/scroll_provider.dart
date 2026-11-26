import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ScrollDirectionState { idle, scrollingUp, scrollingDown }

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
    }

    _stopScrollTimer?.cancel();
    _stopScrollTimer = Timer(const Duration(milliseconds: 200), () {
      if (_scrollState != ScrollDirectionState.idle) {
        _scrollState = ScrollDirectionState.idle;
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void setCurrentSection(String section) {
    _currentSection = section;
    notifyListeners();
  }

  /// Scrolls so the top of the section sits at the top of the viewport (the
  /// fixed nav lives outside the scroll view, so nothing overlaps), nudged down
  /// by [extraOffset] so the section's heading has breathing room.
  void scrollToSection(GlobalKey key, {double extraOffset = 0}) {
    final context = key.currentContext;
    if (context == null || !scrollController.hasClients) return;

    final renderObject = context.findRenderObject();
    if (renderObject == null) return;

    final viewport = RenderAbstractViewport.maybeOf(renderObject);
    if (viewport == null) return;

    final revealed = viewport.getOffsetToReveal(renderObject, 0.0).offset;
    final position = scrollController.position;
    final target = (revealed + extraOffset).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _stopScrollTimer?.cancel();
    scrollController.dispose();
    super.dispose();
  }
}
