import 'package:flutter_test/flutter_test.dart';
import 'package:port_folio/presentation/providers/scroll_provider.dart';

void main() {
  group('ScrollProvider Tests', () {
    late ScrollProvider scrollProvider;

    setUp(() {
      scrollProvider = ScrollProvider();
    });

    tearDown(() {
      scrollProvider.dispose();
    });

    test('initial state is correct', () {
      expect(scrollProvider.scrollOffset, 0.0);
      expect(scrollProvider.currentSection, 'home');
      expect(scrollProvider.scrollState, ScrollDirectionState.idle);
    });

    test('setCurrentSection updates currentSection', () {
      scrollProvider.setCurrentSection('about');
      expect(scrollProvider.currentSection, 'about');
    });

    // Note: scrollState and scrollOffset require a ScrollController attached to a view
    // which is better suited for widget tests, but we've tested the independent logic here.
  });
}
