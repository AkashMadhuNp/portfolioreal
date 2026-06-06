import 'package:flutter/material.dart';

enum CursorType {
  normal,
  hover,
  text,
  action,
}

class CursorProvider extends ChangeNotifier {
  CursorType _type = CursorType.normal;
  double _scale = 1.0;
  String? _customText;
  IconData? _customIcon;

  CursorType get type => _type;
  double get scale => _scale;
  String? get customText => _customText;
  IconData? get customIcon => _customIcon;

  void setHoverState({
    required CursorType type,
    double scale = 1.0,
    String? customText,
    IconData? customIcon,
  }) {
    _type = type;
    _scale = scale;
    _customText = customText;
    _customIcon = customIcon;
    notifyListeners();
  }

  void reset() {
    _type = CursorType.normal;
    _scale = 1.0;
    _customText = null;
    _customIcon = null;
    notifyListeners();
  }
}
