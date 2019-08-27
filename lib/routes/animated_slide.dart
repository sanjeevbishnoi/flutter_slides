import 'package:flutter_web/material.dart';
import 'package:tk.slides/widgets/stack_background_image.dart';
import 'package:tk.slides/widgets/animated_slide_area.dart';
import 'package:tk.slides/widgets/theme_popup_button.dart';
import 'package:tk.slides/widgets/slide_title.dart';
import 'package:tk.slides/slide_content.dart' as slidecontent;
import 'package:tk.slides/constants.dart' as constants;
/*import 'package:tk.slides/models/base_bloc_model.dart';*/
import 'package:tk.slides/models/ui_state.dart';
import 'package:provider/provider.dart';

class AnimatedSlide extends StatefulWidget {
  static const String routeName = 'slide';

  @override
  _TitleRouteState createState() => _TitleRouteState();
}

class _TitleRouteState extends State<AnimatedSlide>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation stackTransformScaleAnimation, backgroundOpacityAnimation;
  Duration animationDuration = Duration(milliseconds: 1500);
  double backgroundOpacityStart, backgroundOpacityEnd;

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

    stackTransformScaleAnimation = Tween<double>(begin: 1.4, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1, curve: Curves.easeInOut),
      ),
    );

    backgroundOpacityAnimation =
        Tween<double>(begin: .7, end: .8).animate(controller);

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
    //backgroundOpacityAnimation =
    //    Tween<double>(begin: .4, end: .8).animate(controller);

    /*return StreamBuilder<UIState>(
      stream: Provider.of<BaseBlocModel<UIState>>(context).stream,
      initialData: constants.kInitialColorTheme,
      builder: (context, snapshot) {
        if (snapshot.data.colorScheme == constants.AppColorScheme.kThemeLight) {
          backgroundOpacityStart = 0;
          backgroundOpacityEnd = .3;
        } else {
          backgroundOpacityStart = .7;
          backgroundOpacityEnd = .9;
        }

        backgroundOpacityAnimation = Tween<double>(
                begin: backgroundOpacityStart, end: backgroundOpacityEnd)
            .animate(controller);*/

    return Scaffold(
      body: Stack(
        children: <Widget>[
          StackBackgroundImage(
            opacity: backgroundOpacityAnimation.value,
            image:
                'https://images.unsplash.com/photo-1555420087-62ca236e0256?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1253&q=80',
            //scale: stackTransformScaleAnimation.value,
            caption: 'Photo by Steve Johnson on UnSplash',
            link: 'https://unsplash.com/photos/OPyoU4zCwWI',
          ),
          SlideTitleWidget(titleText: slidecontent.titleSlide['title']),
          AnimatedSlideArea(
            title: slidecontent.animatedSlide[0][0],
            containerPositionLeft: .6,
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
            title: slidecontent.animatedSlide[1][0],
            containerPositionLeft: .2,
            containerPositionTop: .45,
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
            title: slidecontent.animatedSlide[2][0],
            containerPositionLeft: .6,
            containerPositionTop: .72,
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
          ThemePopupButton(),
        ],
      ),
    );
    //},
    //);
  }
}
