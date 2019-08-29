import 'package:flutter_web/material.dart';
import 'package:provider/provider.dart';
import 'package:tk.slides/constants.dart' as constants;
import 'package:tk.slides/models/ui_state.dart';
import 'package:tk.slides/routes/title_slide.dart';
import 'package:tk.slides/navigation.dart';
import 'package:tk.slides/slide_content.dart' as slidecontent;

void main() {
  runApp(
    Slides(),
  );
}

class Slides extends StatelessWidget {
  Slides({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UIState>.value(
            value: constants.kInitialColorTheme),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Duration animationDuration = Duration(milliseconds: 1000);

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: animationDuration,
      upperBound: 1,
      lowerBound: 0,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UIState uiState = Provider.of<UIState>(context);

    return AnimatedOpacity(
      opacity: animation.value,
      duration: animationDuration,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: uiState.colorScheme == constants.AppColorScheme.kThemeLight
            ? ThemeData.light().copyWith(
                primaryColor: constants.kLightPrimaryColor,
              )
            : ThemeData.dark().copyWith(
                primaryColor: constants.kDarkPrimaryColor,
              ),
        onGenerateRoute: Navigation.generateRoute,
        home: Scaffold(
          body: TitleSlide(),
        ),
        title: slidecontent.titleSlide['title'],
      ),
    );
  }
}
