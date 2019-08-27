import 'package:flutter_web/material.dart';
import 'package:provider/provider.dart';
import 'package:tk.slides/constants.dart' as constants;
//import 'package:tk.slides/models/base_bloc_model.dart';
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
        //Provider<BaseBlocModel<UIState>>.value(value: BaseBlocModel<UIState>()),
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
  Duration animationDuration = Duration(milliseconds: 500);
  //PageController pageController = PageController();
  var currentPageValue = 0.0;

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

    /*pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page;
      });
    });*/
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /*void advancePageView() {
    pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }*/

  @override
  Widget build(BuildContext context) {
    //final BaseBlocModel<UIState> uiStateBloc =
    //    Provider.of<BaseBlocModel<UIState>>(context);

    final UIState uiState = Provider.of<UIState>(context);

    /*return StreamBuilder<UIState>(
      stream: Provider.of<BaseBlocModel<UIState>>(context).stream,
      initialData: constants.kInitialColorTheme,
      builder: (BuildContext context, AsyncSnapshot<UIState> snapshot) {*/
    return AnimatedOpacity(
      opacity: animation.value,
      duration: animationDuration,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //theme: snapshot.data.colorScheme ==
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
          /*body: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Slide1(onClick: advancePageView),
                  PageView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      TitleRoute(),
                      Text("Why Flutter? v"),
                      Text("Anatomy of a Flutter App"),
                    ],
                  )
                ],
              ),*/
        ),
        title: slidecontent.titleSlide['title'],
      ),
    );
    //},
    //);
  }
}
