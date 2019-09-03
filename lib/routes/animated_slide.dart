import 'package:flutter_web/material.dart';
import 'package:tk.slides/widgets/image_caption.dart';
import 'package:tk.slides/widgets/stack_background.dart';
import 'package:tk.slides/widgets/animated_slide_area.dart';
import 'package:tk.slides/widgets/color_theme_popup.dart';
import 'package:tk.slides/widgets/slide_title.dart';
import 'package:tk.slides/slide_content.dart' as slidecontent;
import 'package:tk.slides/widgets/home_icon.dart';
import 'package:tk.slides/widgets/advance_icon.dart';
import 'package:tk.slides/widgets/regress_icon.dart';

class AnimatedSlide extends StatefulWidget {
  const AnimatedSlide({
    Key key,
    this.onClickAdvance,
    this.onClickRegress,
  }) : super(key: key);

  final Function onClickAdvance, onClickRegress;
  static const String routeName = 'slide';

  @override
  _AnimatedSlideState createState() => _AnimatedSlideState();
}

class _AnimatedSlideState extends State<AnimatedSlide>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation stackTransformScaleAnimation, backgroundOpacityAnimation;
  Duration animationDuration = Duration(milliseconds: 1500);

  SlideAppearance slide1Appearance = SlideAppearance.normal;
  SlideAppearance slide2Appearance = SlideAppearance.normal;
  SlideAppearance slide3Appearance = SlideAppearance.normal;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    stackTransformScaleAnimation = Tween<double>(begin: 1.1, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1, curve: Curves.easeInOut),
      ),
    );

    backgroundOpacityAnimation = Tween<double>(begin: .6, end: .8).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1, curve: Curves.easeInOut),
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
            scale: stackTransformScaleAnimation.value,
          ),
          SlideTitle(
            titleText: slidecontent.animatedSlide['title'],
            //backButtonCallback: () => Navigator.pop(context),
          ),
          AnimatedSlideArea(
            title: '1',
            containerPositionLeft: .2,
            containerPositionTop: .18,
            startColor: Theme.of(context).primaryColor,
            endColor: Theme.of(context).primaryColorLight,
            appearance: slide1Appearance,
            appearanceCallback: (val1) {
              setState(() {
                slide1Appearance = val1;
                if (slide1Appearance == SlideAppearance.zoom) {
                  slide2Appearance = SlideAppearance.opaque;
                  slide3Appearance = SlideAppearance.opaque;
                } else {
                  slide2Appearance = SlideAppearance.normal;
                  slide3Appearance = SlideAppearance.normal;
                }
              });
            },
            parentController: controller,
          ),
          AnimatedSlideArea(
            title: '2',
            containerPositionLeft: .4,
            containerPositionTop: .43,
            startColor: Theme.of(context).primaryColor,
            endColor: Theme.of(context).primaryColorLight,
            appearance: slide2Appearance,
            appearanceCallback: (val1) {
              setState(() {
                slide2Appearance = val1;
                if (slide2Appearance == SlideAppearance.zoom) {
                  slide1Appearance = SlideAppearance.opaque;
                  slide3Appearance = SlideAppearance.opaque;
                } else {
                  slide1Appearance = SlideAppearance.normal;
                  slide3Appearance = SlideAppearance.normal;
                }
              });
            },
            parentController: controller,
          ),
          AnimatedSlideArea(
            title: '3',
            containerPositionLeft: .6,
            containerPositionTop: .68,
            startColor: Theme.of(context).primaryColor,
            endColor: Theme.of(context).primaryColorLight,
            appearance: slide3Appearance,
            appearanceCallback: (val1) {
              setState(
                () {
                  slide3Appearance = val1;
                  if (slide3Appearance == SlideAppearance.zoom) {
                    slide2Appearance = SlideAppearance.opaque;
                    slide1Appearance = SlideAppearance.opaque;
                  } else {
                    slide2Appearance = SlideAppearance.normal;
                    slide1Appearance = SlideAppearance.normal;
                  }
                },
              );
            },
            parentController: controller,
          ),
          ImageCaption(
            caption: slidecontent.animatedSlide['backgroundImageCaption'],
            link: slidecontent.animatedSlide['backgroundImageCaptionLink'],
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
