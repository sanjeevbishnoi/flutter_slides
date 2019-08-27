import 'package:flutter_web/material.dart';
import 'package:tk.slides/models/ui_state.dart';

enum AppColorScheme { kThemeLight, kThemeDark }
UIState kInitialColorTheme = UIState(colorScheme: AppColorScheme.kThemeDark);

//const Color kLightPrimaryColor = Color(0xFF1D1D1D);
const Color kLightPrimaryColor = null;
//const Color kDarkPrimaryColor = Color(0xFF2D2D2D);
const Color kDarkPrimaryColor = null;

const String kFontFamily = 'NotoSansRegular';

const kTitleTextStyle = TextStyle(
  fontSize: 80,
  fontFamily: kFontFamily,
);

const kSlideTextStyle = TextStyle(
  fontSize: 50,
  fontFamily: kFontFamily,
);
