import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart' as constants;
import 'package:tk.slides/slide_content.dart' as slidecontent;
import 'package:tk.slides/widgets/color_theme_popup.dart';
import 'package:tk.slides/routes/slide_container.dart';
import 'package:tk.slides/widgets/stack_background.dart';

class TitleSlide extends StatefulWidget {
  TitleSlide({Key key}) : super(key: key);

  static const String routeName = '/';

  @override
  _TitleSlideState createState() => _TitleSlideState();
}

class _TitleSlideState extends State<TitleSlide> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StackBackground(
          opacity: .7,
          image: slidecontent.titleSlide['backgroundImage'],
          caption: slidecontent.titleSlide['backgroundImageCaption'],
          link: slidecontent.titleSlide['backgroundImageCaptionLink'],
        ),
        Container(
          child: GestureDetector(
            onTap: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(TitleSlide.routeName));
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 1000),
                      pageBuilder: (context, __, ___) => SlideContainer()));
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: constants.kTitleSlideHeroKey,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 400,
                        child: Text(
                          slidecontent.titleSlide['title'],
                          style: constants.kTitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ),
        ColorThemePopup(),
      ],
    );
  }
}
