import 'package:flutter_web/material.dart';
import 'package:tk.slides/constants.dart' as constants;

enum SlideAppearance { zoom, opaque, normal }

typedef void AppearanceCallback(SlideAppearance val1);

class AnimatedSlideArea extends StatefulWidget {
  const AnimatedSlideArea({
    Key key,
    @required this.containerPositionLeft,
    @required this.containerPositionTop,
    @required this.parentController,
    @required this.startColor,
    @required this.endColor,
    @required this.appearanceCallback,
    @required this.appearance,
    this.title,
  }) : super(key: key);

  final double containerPositionLeft, containerPositionTop;
  final SlideAppearance appearance;
  final AnimationController parentController;
  final AppearanceCallback appearanceCallback;
  final String title;
  final Color startColor, endColor;

  @override
  _AnimatedSlideAreaState createState() => _AnimatedSlideAreaState();
}

class _AnimatedSlideAreaState extends State<AnimatedSlideArea>
    with TickerProviderStateMixin {
  AnimationController controller, fadeInOpacityController;
  Animation containerWidthAnimation,
      containerHeightAnimation,
      textAnimation,
      containerPositionTopAnimation,
      containerPositionLeftAnimation,
      fadeInOpacityAnimation;
  Animation<Color> colorTween;
  Duration animationDuration = Duration(milliseconds: 1500);
  Duration foregroundAnimationDuration = Duration(milliseconds: 1000);
  Duration fadeInOpacityDuration = Duration(milliseconds: 750);

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    fadeInOpacityController = AnimationController(
      vsync: this,
      duration: fadeInOpacityDuration,
    );

    textAnimation = Tween<double>(begin: 20, end: 50).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1, curve: Curves.easeInOut),
      ),
    );
    containerWidthAnimation = Tween<double>(begin: .2, end: .9).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0, .5, curve: Curves.easeInOut),
      ),
    );
    containerHeightAnimation = Tween<double>(begin: .2, end: .75).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1, curve: Curves.easeInOut),
      ),
    );
    containerPositionTopAnimation =
        Tween<double>(begin: widget.containerPositionTop, end: .15).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1, curve: Curves.easeInOut),
      ),
    );
    containerPositionLeftAnimation =
        Tween<double>(begin: widget.containerPositionLeft, end: .05).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0, .5, curve: Curves.easeInOut),
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    fadeInOpacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(fadeInOpacityController);

    fadeInOpacityController.forward();
    fadeInOpacityController.addListener(() {
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
    colorTween = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(controller);

    return Positioned(
      left: mediaWidth * containerPositionLeftAnimation.value,
      top: mediaHeight * containerPositionTopAnimation.value,
      // this opacity animates the initial fade-in of the slide
      child: AnimatedOpacity(
        opacity: fadeInOpacityAnimation.value,
        duration: fadeInOpacityDuration,

        // this opactiy animates the fade-in/fade-out when boxes are selected
        child: AnimatedOpacity(
          duration: foregroundAnimationDuration,
          opacity: widget.appearance == SlideAppearance.opaque ? 0 : 1,
          child: GestureDetector(
            onTap: () {
              if (widget.appearance == SlideAppearance.zoom) {
                widget.appearanceCallback(SlideAppearance.normal);
                controller.reverse();
                widget.parentController.reverse();
              } else {
                widget.appearanceCallback(SlideAppearance.zoom);
                controller.forward();
                widget.parentController.forward();
              }
            },
            child: Container(
              width: mediaWidth * containerWidthAnimation.value,
              height: mediaHeight * containerHeightAnimation.value,
              decoration: BoxDecoration(
                color: colorTween.value,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    //color: Theme.of(context).primaryColorDark,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: mediaHeight * containerHeightAnimation.value,
                  ),
                  // see https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
                  child: IntrinsicHeight(
                    child: widget.appearance == SlideAppearance.zoom
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: mediaHeight *
                                      .05 *
                                      containerHeightAnimation.value),
                              Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: textAnimation.value,
                                    fontFamily: constants.kFontFamily),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                      height: mediaHeight *
                                          .05 *
                                          containerHeightAnimation.value),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "\u2022 ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: textAnimation.value,
                                            fontFamily: constants.kFontFamily),
                                      ),
                                      // this container allows the text to wrap
                                      Container(
                                        width: mediaWidth *
                                            containerWidthAnimation.value *
                                            .9,
                                        child: Text(
                                          "UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop UI framework for mobile, web and desktop",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: textAnimation.value,
                                              fontFamily:
                                                  constants.kFontFamily),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: mediaHeight *
                                          .05 *
                                          containerHeightAnimation.value),
                                  Text(
                                    "It's amazing!!",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: textAnimation.value,
                                        fontFamily: constants.kFontFamily),
                                  ),
                                  SizedBox(
                                      height: mediaHeight *
                                          .05 *
                                          containerHeightAnimation.value),
                                  Text(
                                    "I love it.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: textAnimation.value,
                                        fontFamily: constants.kFontFamily),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: textAnimation.value,
                                    fontFamily: constants.kFontFamily),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
