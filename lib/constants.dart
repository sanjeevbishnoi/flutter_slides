import 'package:flutter_web/material.dart';
import 'package:tk.slides/models/ui_state.dart';

enum AppColorScheme { kThemeLight, kThemeDark }
UIState kInitialColorTheme = UIState(colorScheme: AppColorScheme.kThemeDark);

//const Color kLightPrimaryColor = Color(0xFF1D1D1D);
const Color kLightPrimaryColor = null;
//const Color kDarkPrimaryColor = Color(0xFF2D2D2D);
const Color kDarkPrimaryColor = null;

const String kFontFamily = 'NotoSansRegular';

const kLargeTextStyle = TextStyle(
  fontSize: 70,
  fontFamily: kFontFamily,
);

const kMediumTextStyle = TextStyle(
  fontSize: 40,
  fontFamily: kFontFamily,
);

const kSmallTextStyle = TextStyle(
  fontSize: 25,
  fontFamily: kFontFamily,
);

const kTitleSlideHeroKey = 'titleSlideHero';

const kBullet = '\u25E6';
