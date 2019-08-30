import 'package:flutter_web/material.dart';
import 'package:tk.slides/widgets/image_caption.dart';
import 'package:tk.slides/widgets/stack_background.dart';
import 'package:tk.slides/widgets/color_theme_popup.dart';
import 'package:tk.slides/widgets/slide_title.dart';
import 'package:tk.slides/slide_content.dart' as slidecontent;

class TextSlide extends StatefulWidget {
  const TextSlide({
    Key key,
    @required this.onClickAdvance,
  }) : super(key: key);

  final Function onClickAdvance;
  static const String routeName = 'slide';

  @override
  _TextSlideState createState() => _TextSlideState();
}

class _TextSlideState extends State<TextSlide>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation stackTransformScaleAnimation, backgroundOpacityAnimation;
  Duration animationDuration = Duration(milliseconds: 1500);

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    backgroundOpacityAnimation = Tween<double>(begin: .6, end: .8).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0, 1, curve: Curves.easeInOut),
      ),
    );

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
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          StackBackground(
            opacity: backgroundOpacityAnimation.value,
            image: slidecontent.animatedSlide['backgroundImage'],
          ),
          SlideTitle(titleText: 'Text Slide'),
          ImageCaption(
            caption: slidecontent.animatedSlide['backgroundImageCaption'],
            link: slidecontent.animatedSlide['backgroundImageCaptionLink'],
          ),
          Positioned(
            top: mediaHeight * .94,
            left: mediaWidth * .9,
            child: GestureDetector(
              onTap: () {
                widget.onClickAdvance();
              },
              child: Icon(Icons.arrow_forward),
            ),
          ),
          ColorThemePopup(),
        ],
      ),
    );
  }
}
