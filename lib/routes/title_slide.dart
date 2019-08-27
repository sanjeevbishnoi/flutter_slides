import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart' as constants;
import 'package:tk.slides/slide_content.dart' as slidecontent;
import 'package:tk.slides/widgets/theme_popup_button.dart';
import 'package:tk.slides/routes/animated_slide.dart';
import 'package:tk.slides/widgets/stack_background_image.dart';

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
        StackBackgroundImage(
          opacity: .7,
          image:
              'https://images.unsplash.com/photo-1553949345-eb786bb3f7ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9',
          caption: 'Photo by Pawl Czerwinski on UnSplash',
          link: 'https://unsplash.com/photos/yn97LNy0bao',
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
                      pageBuilder: (context, __, ___) => AnimatedSlide()));
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: slidecontent.titleSlide['title'],
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        slidecontent.titleSlide['title'],
                        style: constants.kTitleTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ),
        ThemePopupButton(),
      ],
    );
  }
}
