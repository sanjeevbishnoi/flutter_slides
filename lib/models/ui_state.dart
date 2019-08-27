import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart';

class UIState with ChangeNotifier {
  AppColorScheme _colorScheme;

  AppColorScheme get colorScheme => _colorScheme;
  void set colorScheme(AppColorScheme colorScheme) {
    _colorScheme = colorScheme;
    notifyListeners();
  }

  UIState({AppColorScheme colorScheme}) : this._colorScheme = colorScheme;
}
