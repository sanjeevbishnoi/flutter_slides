import 'package:flutter_web/material.dart';
import 'package:tk.slides/widgets/image_caption.dart';
import 'package:tk.slides/widgets/stack_background.dart';
import 'package:tk.slides/widgets/color_theme_popup.dart';
import 'package:tk.slides/widgets/slide_title.dart';
import 'package:tk.slides/constants.dart' as constants;
import 'package:tk.slides/widgets/home_icon.dart';
import 'package:tk.slides/widgets/advance_icon.dart';
import 'package:tk.slides/widgets/regress_icon.dart';

class TextSlide extends StatefulWidget {
  const TextSlide({
    Key key,
    this.onClickAdvance,
    this.onClickRegress,
    this.slideContent,
  }) : super(key: key);

  final Function onClickAdvance, onClickRegress;
  static const String routeName = 'slide';
  final slideContent;

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
            image: widget.slideContent['backgroundImage'],
          ),
          SlideTitle(titleText: widget.slideContent['title']),
          Positioned(
            left: mediaWidth * .1,
            top: mediaHeight * .2,
            child: Container(
              height: mediaHeight * .65,
              width: mediaWidth * .8,
              child: ListView.builder(
                itemCount: widget.slideContent['bodyContent'].length,
                itemBuilder: (BuildContext context, int index) {
                  return FittedBox(
                    alignment: Alignment.topLeft,
                    fit: BoxFit.scaleDown,
                    child: Container(
                      padding:
                          EdgeInsetsDirectional.only(bottom: mediaHeight * .05),
                      child: Text(
                        '${constants.kBullet} ${widget.slideContent['bodyContent'][index]}',
                        style: constants.kMediumTextStyle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ImageCaption(
            caption: widget.slideContent['backgroundImageCaption'],
            link: widget.slideContent['backgroundImageCaptionLink'],
          ),
          AdvanceIcon(onClickAdvance: widget.onClickAdvance),
          RegressIcon(onClickRegress: widget.onClickRegress),
          HomeIcon(),
          ColorThemePopup(),
        ],
      ),
    );
  }
}
